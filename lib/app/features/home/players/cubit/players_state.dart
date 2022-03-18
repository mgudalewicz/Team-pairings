part of 'players_cubit.dart';

@immutable
class PlayersState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const PlayersState(
      {required this.documents,
      required this.isLoading,
      required this.errorMessage});
}
