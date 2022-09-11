import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parowanie/manager/players_data_manager.dart';
import 'package:parowanie/models/player/player.dart';
import 'package:parowanie/service_locator.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  PlayersCubit() : super(const PlayersLoadingState());

  final PlayersDataManager _playersDataManager = sl();

  StreamSubscription<dynamic>? _subscription;

  Future<void> init() async {
    await _playersDataManager.fetch();
    _subscription = _playersDataManager.getPlayers().listen((List<Player> playersList) {
      {
        playersList.sort(((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));
      }
      if (playersList.isEmpty) {
        emit(const PlayersErrorState(error: 'Brak graczy'));
        return;
      }
      emit(PlayersInfoState(
        players: playersList,
      ));
    });
  }

  Future<void> deleted(String id) async {
    try {
      await _playersDataManager.delete(id);
    } catch (error) {
      Fluttertoast.showToast(msg: 'Coś poszło nie tak');
    }
  }

  Future<void> changeValue(bool value, String id) async {
    try {
      await _playersDataManager.changeValue(id, value);
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
