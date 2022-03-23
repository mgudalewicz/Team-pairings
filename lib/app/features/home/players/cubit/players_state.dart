part of 'players_cubit.dart';

@immutable
class PlayersState {
  const PlayersState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  final List<ItemsModel> items;
  final bool isLoading;
  final String errorMessage;
}
