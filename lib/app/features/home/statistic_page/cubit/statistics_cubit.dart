import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:parowanie/app/models/item_model.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit()
      : super(
          const StatisticsState(
            items: [],
            errorMessage: '',
            isLoading: false,
          ),
        );
  StreamSubscription? _streamSubscription;
  Future<void> start() async {
    emit(
      const StatisticsState(
        items: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription =
        FirebaseFirestore.instance.collection('items').orderBy('score', descending: true).snapshots().listen((items) {
      final itemModels = items.docs.map((doc) {
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
      }).toList();
      emit(
        StatisticsState(
          items: itemModels,
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
