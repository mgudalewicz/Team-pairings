class ItemsModel {
  final String id;
  final String name;
  final int goalsCoceded;
  final int goalsScored;
  final int matches;
  final int score;
  final bool value;
  final int wins;
  final int losts;
  final int draws;

  ItemsModel(
    {
    required this.id,
    required this.name,
    required this.goalsCoceded,
    required this.goalsScored,
    required this.matches,
    required this.score,
    required this.value,
    required this.wins,
    required this.losts,
    required this.draws,
  });
}
