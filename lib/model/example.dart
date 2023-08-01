import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'example.freezed.dart';
part 'example.g.dart';

@freezed
class ExampleModel with _$ExampleModel {
  const factory ExampleModel({
    required String name,
    required String code,
    required String description,
  }) = _ExampleModel;

  factory ExampleModel.fromJson(Map<String, Object?> json) =>
      _$ExampleModelFromJson(json);
}

@freezed
class ExampleGroupModel with _$ExampleGroupModel {
  const factory ExampleGroupModel({
    @JsonKey(name: 'groupName') required String name,
    required List<ExampleModel> examples,
  }) = _ExampleGroupModel;

  factory ExampleGroupModel.fromJson(Map<String, Object?> json) =>
      _$ExampleGroupModelFromJson(json);
}
