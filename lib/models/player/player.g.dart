// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: json['id'] as String,
      name: json['name'] as String,
      goalsConceded: json['goals_conceded'] as int,
      goalsScored: json['goals_scored'] as int,
      matches: json['matches'] as int,
      score: json['score'] as int,
      value: json['value'] as bool,
      wins: json['wins'] as int,
      losts: json['losts'] as int,
      draws: json['draws'] as int,
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
      'losts': instance.losts,
      'draws': instance.draws,
    };
