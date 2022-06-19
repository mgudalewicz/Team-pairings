import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/app/models/item_model.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  PlayersCubit()
      : super(
          const PlayersState(
            items: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const PlayersState(
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
      }).toList();
      emit(
        PlayersState(
          items: itemModels,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              PlayersState(
                items: const [],
                isLoading: false,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  Future<void> deleted(String id) async {
    await FirebaseFirestore.instance.collection('items').doc(id).delete();
  }

  Future<void> chamgeValue(bool value, String id) async {
    await FirebaseFirestore.instance.collection('items').doc(id).update({'value': value});
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
