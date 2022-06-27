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
      final itemModel = items.docs.map((doc) {
        return ItemsModel(
          id: doc.id,
          name: doc['name'],
          goalsCoceded: doc['goalsCoceded'],
          goalsScored: doc['goalsScored'],
          matches: doc['matches'],
          score: doc['score'],
          value: doc['value'],
          draws: doc['draws'],
          losts: doc['losts'],
          wins: doc['wins'],
        );
      }).toList()
        ..shuffle();
      List itemModels = itemModel.where((ItemsModel itemsModel) => itemsModel.value == true).toList();
      final int teams = (itemModels.length / 2).floor();
      int i = 0;
      List players = [];
      for (i; i < teams; i++) {
        int x = i + 1;
        int y = 2 * i;
        players.add({
          'group': 'Druzyna $x',
          'name': itemModels[y].name,
          'id': itemModels[y].id,
          'value': false,
        });
        players.add({
          'group': 'Druzyna $x',
          'name': itemModels[y + 1].name,
          'id': itemModels[y + 1].id,
          'value': false,
        });
        if (itemModels.length % 2 == 1 && i == teams - 1) {
          int lastTeam = teams + 1;
          int lastIndex = 2 * teams;
          players.add({
            'group': 'Druzyna $lastTeam',
            'name': itemModels[lastIndex].name,
            'id': itemModels[lastIndex].id,
            'value': false,
          });
        }
      }
      emit(
        TeamsState(
          items: players,
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
