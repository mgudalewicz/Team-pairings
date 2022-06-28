import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/app/models/item_model.dart';
import 'package:parowanie/widgets/checkbox_state.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit()
      : super(
          const TeamsState(
            items: [],
            errorMessage: '',
            isLoading: false,
            checkBox: [],
          ),
        );
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const TeamsState(
        items: [],
        errorMessage: '',
        isLoading: true,
        checkBox: [],
      ),
    );

    _streamSubscription =
        FirebaseFirestore.instance.collection('items').orderBy('score', descending: true).snapshots().listen((items) {
      final itemModel = items.docs.map((doc) {
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
      }).toList()
        ..shuffle();
      List itemModels = itemModel.where((ItemsModel itemsModel) => itemsModel.value == true).toList();
      final int teams = (itemModels.length / 2).floor();
      final List checkBox = [];
      int i = 0;
      List players = [];
      for (i; i < teams; i++) {
        int x = i + 1;
        int y = 2 * i;
        checkBox.add(CheckBoxState(title: 'Drużyna $x'));
        players.add({
          'group': 'Drużyna $x',
          'name': itemModels[y].name,
          'id': itemModels[y].id,
          'value': false,
        });
        players.add({
          'group': 'Drużyna $x',
          'name': itemModels[y + 1].name,
          'id': itemModels[y + 1].id,
          'value': false,
        });
        if (itemModels.length % 2 == 1 && i == teams - 1) {
          int lastTeam = teams + 1;
          int lastIndex = 2 * teams;
          players.add({
            'group': 'Drużyna $lastTeam',
            'name': itemModels[lastIndex].name,
            'id': itemModels[lastIndex].id,
            'value': false,
          });
          checkBox.add(CheckBoxState(title: 'Drużyna $lastTeam'));
        }
      }
      emit(
        TeamsState(
          items: players,
          checkBox: checkBox,
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
                checkBox: const [],
              ),
            );
          });
  }

  Future<void> endMatch(String id, int goalsConceded, int goalsScored) async {
    int win = 0;
    int lost = 0;
    int draw = 0;
    int score = 0;

    if (goalsConceded < goalsScored) {
      win++;
      score += 3;
    } else if (goalsConceded > goalsScored) {
      lost++;
    } else {
      draw++;
      score += 1;
    }
    await FirebaseFirestore.instance.collection('items').doc(id).update({
      'goalsConceded': FieldValue.increment(goalsConceded),
      'goalsScored': FieldValue.increment(goalsScored),
      'matches': FieldValue.increment(1),
      'wins': FieldValue.increment(win),
      'losts': FieldValue.increment(lost),
      'draws': FieldValue.increment(draw),
      'score': FieldValue.increment(score),
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
