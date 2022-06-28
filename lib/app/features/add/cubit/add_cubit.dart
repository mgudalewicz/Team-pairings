import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/repositories/items_repository.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemsRepository) : super(const AddState());

  final ItemsRepository _itemsRepository;

  Future<void> addPlayers(String text) async {
    try {
      await _itemsRepository.addPlayers(text: text);
    } catch (error) {
      print(error);
    }
  }
}
