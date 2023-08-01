// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExampleModel _$$_ExampleModelFromJson(Map<String, dynamic> json) =>
    _$_ExampleModel(
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$_ExampleModelToJson(_$_ExampleModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
    };

_$_ExampleGroupModel _$$_ExampleGroupModelFromJson(Map<String, dynamic> json) =>
    _$_ExampleGroupModel(
      name: json['groupName'] as String,
      examples: (json['examples'] as List<dynamic>)
          .map((e) => ExampleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ExampleGroupModelToJson(
        _$_ExampleGroupModel instance) =>
    <String, dynamic>{
      'groupName': instance.name,
      'examples': instance.examples,
    };
