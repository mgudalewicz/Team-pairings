class ItemModel {
  final String id;
  final String name;
  final int score;
  final int goalsConceded;
  final int relaseDate;
  bool value;

  ItemModel({
    required this.id,
    required this.name,
    required this.score,
    required this.goalsConceded,
    required this.relaseDate,
    this.value = false,
  });
}
