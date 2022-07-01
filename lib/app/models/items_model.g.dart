// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemsModel _$$_ItemsModelFromJson(Map<String, dynamic> json) =>
    _$_ItemsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      goalsConceded: json['goalsConceded'] as int,
      goalsScored: json['goalsScored'] as int,
      matches: json['matches'] as int,
      score: json['score'] as int,
      value: json['value'] as bool,
      wins: json['wins'] as int,
      losts: json['losts'] as int,
      draws: json['draws'] as int,
    );

Map<String, dynamic> _$$_ItemsModelToJson(_$_ItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'goalsConceded': instance.goalsConceded,
      'goalsScored': instance.goalsScored,
      'matches': instance.matches,
      'score': instance.score,
      'value': instance.value,
      'wins': instance.wins,
      'losts': instance.losts,
      'draws': instance.draws,
    };
