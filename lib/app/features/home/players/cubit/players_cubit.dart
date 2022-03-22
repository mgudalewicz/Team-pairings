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
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const PlayersState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('Players')
        .orderBy('score', descending: true)
        .snapshots()
        .listen((data) {
      final itemModels = data.docs.map((doc) {
        return ItemsModel(
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
          documents: itemModels,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          PlayersState(
            documents: const [],
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
