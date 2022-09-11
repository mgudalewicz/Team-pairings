part of 'teams_cubit.dart';

abstract class TeamsState extends Equatable {
  const TeamsState();

  @override
  List<dynamic> get props => <dynamic>[];
}

class TeamsLoadingState extends TeamsState {
  const TeamsLoadingState();
}

class TeamsInfoState extends TeamsState {
  const TeamsInfoState({
    required this.players,
    required this.checkbox,
  });
  final List players;
  final List checkbox;

  @override
  List<dynamic> get props => <dynamic>[
        players,
        checkbox,
      ];
}

class TeamsErrorState extends TeamsState {
  const TeamsErrorState({
    required this.error,
  });

  final String error;

  @override
  List<dynamic> get props => <dynamic>[
        error,
      ];
}
