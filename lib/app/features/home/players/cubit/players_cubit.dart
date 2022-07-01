import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/app/models/check_box_state.dart';
import 'package:parowanie/repositories/items_repository.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  PlayersCubit(this._itemsRepository)
      : super(
          const PlayersState(
            items: [],
            errorMessage: '',
            isLoading: false,
            players: [],
            checkBox: [],

          ),
        );

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const PlayersState(
        items: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = _itemsRepository.getItemsStream().listen((items) {
      List itemModels = items.where((itemsModel) => itemsModel.value == true).toList()..shuffle();
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
        PlayersState(
          checkBox: checkBox,
          players: players,
          items: items,
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
    try {
      await _itemsRepository.deleted(id: id);
    } catch (error) {
      print(error);
    }
  }

  Future<void> chamgeValue(bool value, String id) async {
    try {
      await _itemsRepository.chamgeValue(value: value, id: id);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
