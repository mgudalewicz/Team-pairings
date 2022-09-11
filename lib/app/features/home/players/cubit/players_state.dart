part of 'players_cubit.dart';

abstract class PlayersState extends Equatable {
  const PlayersState();

  @override
  List<dynamic> get props => <dynamic>[];
}

class PlayersLoadingState extends PlayersState {
  const PlayersLoadingState();
}

class PlayersInfoState extends PlayersState {
  const PlayersInfoState({
    required this.players,
  });
  final List<Player> players;

  @override
  List<dynamic> get props => <dynamic>[
        players,
      ];
}

class PlayersErrorState extends PlayersState {
  const PlayersErrorState({
    required this.error,
  });

  final String error;

  @override
  List<dynamic> get props => <dynamic>[
        error,
      ];
}
