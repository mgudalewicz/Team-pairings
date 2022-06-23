import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/app/models/item_model.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit()
      : super(
          const TeamsState(
            items: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const TeamsState(
        items: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription =
        FirebaseFirestore.instance.collection('items').orderBy('score', descending: true).snapshots().listen((items) {
      final itemModels = items.docs.map((doc) {
        return ItemsModel(
          id: doc.id,
          name: doc['name'],
          goalsCoceded: doc['goalsCoceded'],
          goalsScored: doc['goalsScored'],
          matches: doc['matches'],
          score: doc['score'],
          value: doc['value'],
        );
      }).toList()
        ..shuffle();
      emit(
        TeamsState(
          items: itemModels.where((ItemsModel itemsModel) => itemsModel.value == true).toList(),
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              TeamsState(
                items: const [],
                isLoading: false,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
