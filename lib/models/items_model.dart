import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:parowanie/schema/items_fields.dart';

part 'items_model.g.dart';

@JsonSerializable()
class ItemsModel extends Equatable {
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
  Map<String, dynamic> toJson() {
    return _$ItemsModelToJson(this);
  }

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

  @override
  List<Object?> get props => <dynamic>[
        id,
        name,
        goalsConceded,
        goalsScored,
        matches,
        score,
        value,
        wins,
        losts,
        draws,
      ];
}
