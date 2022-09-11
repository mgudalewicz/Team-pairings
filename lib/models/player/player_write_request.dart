import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:parowanie/schema/players_fields.dart';

part 'player_write_request.g.dart';

@JsonSerializable()
class PlayerWriteRequest extends Equatable {
  const PlayerWriteRequest({
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

  factory PlayerWriteRequest.fromJson(Map<String, dynamic> json) => _$PlayerWriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerWriteRequestToJson(this);

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
