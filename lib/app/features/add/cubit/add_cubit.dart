import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/manager/players_data_manager.dart';
import 'package:parowanie/models/player/player_write_request.dart';
import 'package:parowanie/service_locator.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(const AddState());

  final PlayersDataManager _playersDataManager = sl();

  Future<void> create(String text) async {
    final PlayerWriteRequest playerWriteRequest = PlayerWriteRequest(
      name: text,
      draws: 0,
      goalsConceded: 0,
      goalsScored: 0,
      losts: 0,
      matches: 0,
      score: 0,
      value: false,
      wins: 0,
    );
    try {
      await _playersDataManager.create(playerWriteRequest);
    } catch (error) {
      Fluttertoast.showToast(msg: 'Coś poszło nie tak');
    }
  }
}
