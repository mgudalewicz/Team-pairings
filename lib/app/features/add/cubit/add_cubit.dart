import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/app/models/item_model.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit()
      : super(
          const AddState(
            items: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const AddState(
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
          goalsConceded: doc['goalsConceded'],
          goalsScored: doc['goalsScored'],
          matches: doc['matches'],
          score: doc['score'],
          value: doc['value'],
          draws: doc['draws'],
          losts: doc['losts'],
          wins: doc['wins'],
        );
      }).toList();
      emit(
        AddState(
          items: itemModels,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              AddState(
                items: const [],
                isLoading: false,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  Future<void> addPlayers(String text) async {
    await FirebaseFirestore.instance.collection('items').add({
      'name': text,
      'goalsConceded': 0,
      'goalsScored': 0,
      'matches': 0,
      'score': 0,
      'value': false,
      'draws': 0,
      'losts': 0,
      'wins': 0,
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
