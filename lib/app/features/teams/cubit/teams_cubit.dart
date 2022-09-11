import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parowanie/manager/players_data_manager.dart';
import 'package:parowanie/models/player/player.dart';
import 'package:parowanie/models/player/player_write_request.dart';
import 'package:parowanie/service_locator.dart';
import 'package:parowanie/support_files/widgets/checkbox_state.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit() : super(const TeamsLoadingState());

  final PlayersDataManager _playersDataManager = sl();

  StreamSubscription<dynamic>? _subscription;

  Future<void> init() async {
    await _playersDataManager.fetch();
    _subscription = _playersDataManager.getPlayers().listen((List<Player> playersList) {
      List<Player> players = playersList.where((player) => player.value == true).toList()..shuffle();
      ;
      final int teams = (players.length / 2).floor();
      final List checkBox = [];
      int i = 0;
      List selectedPlayers = [];
      for (i; i < teams; i++) {
        int x = i + 1;
        int y = 2 * i;
        checkBox.add(CheckBoxState(title: 'Drużyna $x'));
        selectedPlayers.add({
          'group': 'Drużyna $x',
          'name': players[y].name,
          'id': players[y].id,
          'value': false,
        });
        selectedPlayers.add({
          'group': 'Drużyna $x',
          'name': players[y + 1].name,
          'id': players[y + 1].id,
          'value': false,
        });
        if (players.length % 2 == 1 && i == teams - 1) {
          int lastTeam = teams + 1;
          int lastIndex = 2 * teams;
          selectedPlayers.add({
            'group': 'Drużyna $lastTeam',
            'name': players[lastIndex].name,
            'id': players[lastIndex].id,
            'value': false,
          });
          checkBox.add(CheckBoxState(title: 'Drużyna $lastTeam'));
        }
      }

      if (playersList.isEmpty) {
        emit(const TeamsErrorState(error: 'Brak graczy'));
        return;
      }
      emit(TeamsInfoState(
        players: selectedPlayers,
        checkbox: checkBox,
      ));
    });
  }

  Future<void> endMatch({required String id, required int goalsScored, required int goalsConceded}) async {
    try {
      await _playersDataManager.endMatch(
        id: id,
        goalsScored: goalsScored,
        goalsConceded: goalsConceded,
      );
    } catch (error) {
      Fluttertoast.showToast(msg: 'Coś poszło nie tak');
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
