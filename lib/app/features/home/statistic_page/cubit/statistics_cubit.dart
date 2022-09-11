import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parowanie/manager/players_data_manager.dart';
import 'package:parowanie/models/player/player.dart';
import 'package:parowanie/service_locator.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(const StatisticsLoadingState());

  final PlayersDataManager _playersDataManager = sl();

  StreamSubscription<dynamic>? _subscription;

  Future<void> init() async {
    await _playersDataManager.fetch();

    _subscription = _playersDataManager.getPlayers().listen((List<Player> playersList) {
      {
        playersList.sort(((a, b) => a.score < b.score ? 1 : -1));
      }
      if (playersList.isEmpty) {
        emit(const StatisticsErrorState(error: 'Brak graczy'));
        return;
      }
      emit(StatisticsInfoState(
        players: playersList,
      ));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
