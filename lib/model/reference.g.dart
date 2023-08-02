// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReferenceGroupModel _$$_ReferenceGroupModelFromJson(
        Map<String, dynamic> json) =>
    _$_ReferenceGroupModel(
      groupName: json['groupName'] as String,
      subgroups: (json['subgroups'] as List<dynamic>)
          .map(
              (e) => ReferenceSubGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ReferenceGroupModelToJson(
        _$_ReferenceGroupModel instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'subgroups': instance.subgroups,
    };

_$_ReferenceSubGroupModel _$$_ReferenceSubGroupModelFromJson(
        Map<String, dynamic> json) =>
    _$_ReferenceSubGroupModel(
      subgroupName: json['subgroupName'] as String?,
      tokens: (json['tokens'] as List<dynamic>)
          .map((e) => ReferenceTokenModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ReferenceSubGroupModelToJson(
        _$_ReferenceSubGroupModel instance) =>
    <String, dynamic>{
      'subgroupName': instance.subgroupName,
      'tokens': instance.tokens,
    };

_$_ReferenceTokenModel _$$_ReferenceTokenModelFromJson(
        Map<String, dynamic> json) =>
    _$_ReferenceTokenModel(
      label: json['label'] as String,
      description: json['description'] as String,
      examples:
          (json['examples'] as List<dynamic>).map((e) => e as String).toList(),
      href: json['href'] as String,
      returns: json['returns'] as String?,
      syntax:
          (json['syntax'] as List<dynamic>).map((e) => e as String).toList(),
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => ReferenceTokenParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ReferenceTokenModelToJson(
        _$_ReferenceTokenModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'description': instance.description,
      'examples': instance.examples,
      'href': instance.href,
      'returns': instance.returns,
      'syntax': instance.syntax,
      'parameters': instance.parameters,
    };

_$_ReferenceTokenParam _$$_ReferenceTokenParamFromJson(
        Map<String, dynamic> json) =>
    _$_ReferenceTokenParam(
      paramName: json['paramName'] as String,
      paramType: json['paramType'] as String,
      paramDescription: json['paramDescription'] as String,
    );

Map<String, dynamic> _$$_ReferenceTokenParamToJson(
        _$_ReferenceTokenParam instance) =>
    <String, dynamic>{
      'paramName': instance.paramName,
      'paramType': instance.paramType,
      'paramDescription': instance.paramDescription,
    };
