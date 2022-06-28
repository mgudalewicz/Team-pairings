import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/app/models/item_model.dart';
import 'package:parowanie/repositories/items_repository.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit(this._itemsRepository)
      : super(
          const StatisticsState(
            items: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const StatisticsState(
        items: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = _itemsRepository.getItemsStreamStatistic().listen((items) {
      emit(
        StatisticsState(
          items: items,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          StatisticsState(
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
