class ItemsModel {
  final String id;
  final String name;
  final int goalsConceded;
  final int goalsScored;
  final int matches;
  final int score;
  final bool value;
  final int wins;
  final int losts;
  final int draws;

  ItemsModel({
    required this.id,
    required this.name,
    required this.goalsConceded,
    required this.goalsScored,
    required this.matches,
    required this.score,
    required this.value,
    required this.wins,
    required this.losts,
    required this.draws,
  });
}
