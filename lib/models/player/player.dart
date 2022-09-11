import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:parowanie/schema/players_fields.dart';

part 'player.g.dart';

@JsonSerializable()
class Player extends Equatable {
  const Player({
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

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  @JsonKey(name: PlayersFields.id)
  final String id;

  @JsonKey(name: PlayersFields.name)
  final String name;

  @JsonKey(name: PlayersFields.goalsConceded)
  final int goalsConceded;

  @JsonKey(name: PlayersFields.goalsScored)
  final int goalsScored;

  @JsonKey(name: PlayersFields.matches)
  final int matches;

  @JsonKey(name: PlayersFields.score)
  final int score;

  @JsonKey(name: PlayersFields.value)
  final bool value;

  @JsonKey(name: PlayersFields.wins)
  final int wins;

  @JsonKey(name: PlayersFields.losts)
  final int losts;

  @JsonKey(name: PlayersFields.draws)
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
