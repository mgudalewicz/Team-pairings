import 'package:json_annotation/json_annotation.dart';
import 'package:parowanie/app/schema/items_fields.dart';

part 'items_model.g.dart';

@JsonSerializable()
class ItemsModel {
  
  @JsonKey(name: ItemFields.id)
  final String id;

    @JsonKey(name: ItemFields.name)
  final String name;

    @JsonKey(name: ItemFields.goalsConceded)
  final int goalsConceded;

    @JsonKey(name: ItemFields.goalsScored)
  final int goalsScored;

    @JsonKey(name: ItemFields.matches)
  final int matches;

    @JsonKey(name: ItemFields.score)
  final int score;

    @JsonKey(name: ItemFields.value)
  final bool value;

    @JsonKey(name: ItemFields.wins)
  final int wins;

    @JsonKey(name: ItemFields.losts)
  final int losts;

    @JsonKey(name: ItemFields.draws)
  final int draws;

  const ItemsModel({
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

    factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return _$ItemsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ItemsModelToJson(this);
}
