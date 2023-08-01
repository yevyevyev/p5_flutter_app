// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExampleModel _$ExampleModelFromJson(Map<String, dynamic> json) {
  return _ExampleModel.fromJson(json);
}

/// @nodoc
mixin _$ExampleModel {
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExampleModelCopyWith<ExampleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleModelCopyWith<$Res> {
  factory $ExampleModelCopyWith(
          ExampleModel value, $Res Function(ExampleModel) then) =
      _$ExampleModelCopyWithImpl<$Res, ExampleModel>;
  @useResult
  $Res call({String name, String code, String description});
}

/// @nodoc
class _$ExampleModelCopyWithImpl<$Res, $Val extends ExampleModel>
    implements $ExampleModelCopyWith<$Res> {
  _$ExampleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExampleModelCopyWith<$Res>
    implements $ExampleModelCopyWith<$Res> {
  factory _$$_ExampleModelCopyWith(
          _$_ExampleModel value, $Res Function(_$_ExampleModel) then) =
      __$$_ExampleModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String code, String description});
}

/// @nodoc
class __$$_ExampleModelCopyWithImpl<$Res>
    extends _$ExampleModelCopyWithImpl<$Res, _$_ExampleModel>
    implements _$$_ExampleModelCopyWith<$Res> {
  __$$_ExampleModelCopyWithImpl(
      _$_ExampleModel _value, $Res Function(_$_ExampleModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? code = null,
    Object? description = null,
  }) {
    return _then(_$_ExampleModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExampleModel with DiagnosticableTreeMixin implements _ExampleModel {
  const _$_ExampleModel(
      {required this.name, required this.code, required this.description});

  factory _$_ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$$_ExampleModelFromJson(json);

  @override
  final String name;
  @override
  final String code;
  @override
  final String description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExampleModel(name: $name, code: $code, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExampleModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExampleModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExampleModelCopyWith<_$_ExampleModel> get copyWith =>
      __$$_ExampleModelCopyWithImpl<_$_ExampleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExampleModelToJson(
      this,
    );
  }
}

abstract class _ExampleModel implements ExampleModel {
  const factory _ExampleModel(
      {required final String name,
      required final String code,
      required final String description}) = _$_ExampleModel;

  factory _ExampleModel.fromJson(Map<String, dynamic> json) =
      _$_ExampleModel.fromJson;

  @override
  String get name;
  @override
  String get code;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$_ExampleModelCopyWith<_$_ExampleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ExampleGroupModel _$ExampleGroupModelFromJson(Map<String, dynamic> json) {
  return _ExampleGroupModel.fromJson(json);
}

/// @nodoc
mixin _$ExampleGroupModel {
  @JsonKey(name: 'groupName')
  String get name => throw _privateConstructorUsedError;
  List<ExampleModel> get examples => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExampleGroupModelCopyWith<ExampleGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleGroupModelCopyWith<$Res> {
  factory $ExampleGroupModelCopyWith(
          ExampleGroupModel value, $Res Function(ExampleGroupModel) then) =
      _$ExampleGroupModelCopyWithImpl<$Res, ExampleGroupModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'groupName') String name, List<ExampleModel> examples});
}

/// @nodoc
class _$ExampleGroupModelCopyWithImpl<$Res, $Val extends ExampleGroupModel>
    implements $ExampleGroupModelCopyWith<$Res> {
  _$ExampleGroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? examples = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<ExampleModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExampleGroupModelCopyWith<$Res>
    implements $ExampleGroupModelCopyWith<$Res> {
  factory _$$_ExampleGroupModelCopyWith(_$_ExampleGroupModel value,
          $Res Function(_$_ExampleGroupModel) then) =
      __$$_ExampleGroupModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'groupName') String name, List<ExampleModel> examples});
}

/// @nodoc
class __$$_ExampleGroupModelCopyWithImpl<$Res>
    extends _$ExampleGroupModelCopyWithImpl<$Res, _$_ExampleGroupModel>
    implements _$$_ExampleGroupModelCopyWith<$Res> {
  __$$_ExampleGroupModelCopyWithImpl(
      _$_ExampleGroupModel _value, $Res Function(_$_ExampleGroupModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? examples = null,
  }) {
    return _then(_$_ExampleGroupModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value._examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<ExampleModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExampleGroupModel
    with DiagnosticableTreeMixin
    implements _ExampleGroupModel {
  const _$_ExampleGroupModel(
      {@JsonKey(name: 'groupName') required this.name,
      required final List<ExampleModel> examples})
      : _examples = examples;

  factory _$_ExampleGroupModel.fromJson(Map<String, dynamic> json) =>
      _$$_ExampleGroupModelFromJson(json);

  @override
  @JsonKey(name: 'groupName')
  final String name;
  final List<ExampleModel> _examples;
  @override
  List<ExampleModel> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExampleGroupModel(name: $name, examples: $examples)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExampleGroupModel'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('examples', examples));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExampleGroupModel &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._examples, _examples));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_examples));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExampleGroupModelCopyWith<_$_ExampleGroupModel> get copyWith =>
      __$$_ExampleGroupModelCopyWithImpl<_$_ExampleGroupModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExampleGroupModelToJson(
      this,
    );
  }
}

abstract class _ExampleGroupModel implements ExampleGroupModel {
  const factory _ExampleGroupModel(
      {@JsonKey(name: 'groupName') required final String name,
      required final List<ExampleModel> examples}) = _$_ExampleGroupModel;

  factory _ExampleGroupModel.fromJson(Map<String, dynamic> json) =
      _$_ExampleGroupModel.fromJson;

  @override
  @JsonKey(name: 'groupName')
  String get name;
  @override
  List<ExampleModel> get examples;
  @override
  @JsonKey(ignore: true)
  _$$_ExampleGroupModelCopyWith<_$_ExampleGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}
