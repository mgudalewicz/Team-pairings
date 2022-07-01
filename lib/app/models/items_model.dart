import 'package:freezed_annotation/freezed_annotation.dart';

part 'items_model.freezed.dart';
part 'items_model.g.dart';

@freezed
class ItemsModel with _$ItemsModel {
  factory ItemsModel({
    required String id,
    required String name,
    required int goalsConceded,
    required int goalsScored,
    required int matches,
    required int score,
    required bool value,
    required int wins,
    required int losts,
    required int draws,
  }) = _ItemsModel;

  factory ItemsModel.fromJson(Map<String, dynamic> json) => _$ItemsModelFromJson(json);
}
