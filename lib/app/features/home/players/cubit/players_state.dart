part of 'players_cubit.dart';

@immutable
class PlayersState {
  final List<ItemsModel> documents;
  final bool isLoading;
  final String errorMessage;

  const PlayersState(
      {required this.documents,
      required this.isLoading,
      required this.errorMessage});
}
