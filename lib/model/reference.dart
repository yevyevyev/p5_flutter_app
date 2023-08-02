import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

@freezed
class ReferenceGroupModel with _$ReferenceGroupModel {
  const factory ReferenceGroupModel({
    required String groupName,
    required List<ReferenceSubGroupModel> subgroups,
  }) = _ReferenceGroupModel;

  factory ReferenceGroupModel.fromJson(Map<String, Object?> json) =>
      _$ReferenceGroupModelFromJson(json);
}

@freezed
class ReferenceSubGroupModel with _$ReferenceSubGroupModel {
  const factory ReferenceSubGroupModel({
    required String? subgroupName,
    required List<ReferenceTokenModel> tokens,
  }) = _ReferenceSubGroupModel;

  factory ReferenceSubGroupModel.fromJson(Map<String, Object?> json) =>
      _$ReferenceSubGroupModelFromJson(json);
}

@freezed
class ReferenceTokenModel with _$ReferenceTokenModel {
  const factory ReferenceTokenModel({
    required String label,
    required String description,
    required List<String> examples,
    required String href,
    required String? returns,
    required List<String> syntax,
    required List<ReferenceTokenParam> parameters,
  }) = _ReferenceTokenModel;

  factory ReferenceTokenModel.fromJson(Map<String, Object?> json) =>
      _$ReferenceTokenModelFromJson(json);
}

@freezed
class ReferenceTokenParam with _$ReferenceTokenParam {
  const factory ReferenceTokenParam({
    required String paramName,
    required String paramType,
    required String paramDescription,
  }) = _ReferenceTokenParam;

  factory ReferenceTokenParam.fromJson(Map<String, Object?> json) =>
      _$ReferenceTokenParamFromJson(json);
}
