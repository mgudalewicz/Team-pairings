import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/repositories/items_repository.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit(this._itemsRepository) : super(const TeamsState());

  

  final ItemsRepository _itemsRepository;

  Future<void> endMatch(String id, int goalsConceded, int goalsScored) async {
    try {
      await _itemsRepository.endMatch(id: id, goalsConceded: goalsConceded, goalsScored: goalsScored);
    } catch (error) {
      print(error);
    }
  }
}
