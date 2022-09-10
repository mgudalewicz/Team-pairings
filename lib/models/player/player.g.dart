// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: json['id'] as String,
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

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
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
