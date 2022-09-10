// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_write_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerWriteRequest _$PlayerWriteRequestFromJson(Map<String, dynamic> json) =>
    PlayerWriteRequest(
      name: json['name'] as String,
      goalsConceded: json['goals_conceded'] as String,
      goalsScored: json['goals_scored'] as String,
      matches: json['matches'] as String,
      score: json['score'] as String,
      value: json['value'] as String,
      wins: json['wins'] as String,
      losts: json['lost'] as String,
      draws: json['draws'] as String,
    );

Map<String, dynamic> _$PlayerWriteRequestToJson(PlayerWriteRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'goals_conceded': instance.goalsConceded,
      'goals_scored': instance.goalsScored,
      'matches': instance.matches,
      'score': instance.score,
      'value': instance.value,
      'wins': instance.wins,
      'lost': instance.losts,
      'draws': instance.draws,
    };
