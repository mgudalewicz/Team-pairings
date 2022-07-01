part of 'players_cubit.dart';

@immutable
class PlayersState {
  const PlayersState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage = '',
    this.players = const [],
    this.checkBox = const [],
  });

  final List<dynamic> items;
  final bool isLoading;
  final String errorMessage;
  final List<dynamic> players;
  final List<dynamic> checkBox;
}
