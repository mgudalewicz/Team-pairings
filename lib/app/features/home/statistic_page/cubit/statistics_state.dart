part of 'statistics_cubit.dart';

abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<dynamic> get props => <dynamic>[];
}

class StatisticsLoadingState extends StatisticsState {
  const StatisticsLoadingState();
}

class StatisticsInfoState extends StatisticsState {
  const StatisticsInfoState({
    required this.players,

  });
  final List<Player> players;


  @override
  List<dynamic> get props => <dynamic>[
  players,
      ];
}

class StatisticsErrorState extends StatisticsState {
  const StatisticsErrorState({
    required this.error,
  });

  final String error;

  @override
  List<dynamic> get props => <dynamic>[
        error,
      ];
}
