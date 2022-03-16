class ItemModel {
  final String name;
  final int score;
  final int goalsConceded;
  final int relaseDate;
  bool value;

  ItemModel({
    required this.name,
    required this.score,
    required this.goalsConceded,
    required this.relaseDate,
    this.value = false,
  });
}
