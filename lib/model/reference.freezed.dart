// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReferenceGroupModel _$ReferenceGroupModelFromJson(Map<String, dynamic> json) {
  return _ReferenceGroupModel.fromJson(json);
}

/// @nodoc
mixin _$ReferenceGroupModel {
  String get groupName => throw _privateConstructorUsedError;
  List<ReferenceSubGroupModel> get subgroups =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferenceGroupModelCopyWith<ReferenceGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceGroupModelCopyWith<$Res> {
  factory $ReferenceGroupModelCopyWith(
          ReferenceGroupModel value, $Res Function(ReferenceGroupModel) then) =
      _$ReferenceGroupModelCopyWithImpl<$Res, ReferenceGroupModel>;
  @useResult
  $Res call({String groupName, List<ReferenceSubGroupModel> subgroups});
}

/// @nodoc
class _$ReferenceGroupModelCopyWithImpl<$Res, $Val extends ReferenceGroupModel>
    implements $ReferenceGroupModelCopyWith<$Res> {
  _$ReferenceGroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
    Object? subgroups = null,
  }) {
    return _then(_value.copyWith(
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      subgroups: null == subgroups
          ? _value.subgroups
          : subgroups // ignore: cast_nullable_to_non_nullable
              as List<ReferenceSubGroupModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReferenceGroupModelCopyWith<$Res>
    implements $ReferenceGroupModelCopyWith<$Res> {
  factory _$$_ReferenceGroupModelCopyWith(_$_ReferenceGroupModel value,
          $Res Function(_$_ReferenceGroupModel) then) =
      __$$_ReferenceGroupModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String groupName, List<ReferenceSubGroupModel> subgroups});
}

/// @nodoc
class __$$_ReferenceGroupModelCopyWithImpl<$Res>
    extends _$ReferenceGroupModelCopyWithImpl<$Res, _$_ReferenceGroupModel>
    implements _$$_ReferenceGroupModelCopyWith<$Res> {
  __$$_ReferenceGroupModelCopyWithImpl(_$_ReferenceGroupModel _value,
      $Res Function(_$_ReferenceGroupModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupName = null,
    Object? subgroups = null,
  }) {
    return _then(_$_ReferenceGroupModel(
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      subgroups: null == subgroups
          ? _value._subgroups
          : subgroups // ignore: cast_nullable_to_non_nullable
              as List<ReferenceSubGroupModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReferenceGroupModel
    with DiagnosticableTreeMixin
    implements _ReferenceGroupModel {
  const _$_ReferenceGroupModel(
      {required this.groupName,
      required final List<ReferenceSubGroupModel> subgroups})
      : _subgroups = subgroups;

  factory _$_ReferenceGroupModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReferenceGroupModelFromJson(json);

  @override
  final String groupName;
  final List<ReferenceSubGroupModel> _subgroups;
  @override
  List<ReferenceSubGroupModel> get subgroups {
    if (_subgroups is EqualUnmodifiableListView) return _subgroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subgroups);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReferenceGroupModel(groupName: $groupName, subgroups: $subgroups)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReferenceGroupModel'))
      ..add(DiagnosticsProperty('groupName', groupName))
      ..add(DiagnosticsProperty('subgroups', subgroups));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReferenceGroupModel &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            const DeepCollectionEquality()
                .equals(other._subgroups, _subgroups));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, groupName, const DeepCollectionEquality().hash(_subgroups));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReferenceGroupModelCopyWith<_$_ReferenceGroupModel> get copyWith =>
      __$$_ReferenceGroupModelCopyWithImpl<_$_ReferenceGroupModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReferenceGroupModelToJson(
      this,
    );
  }
}

abstract class _ReferenceGroupModel implements ReferenceGroupModel {
  const factory _ReferenceGroupModel(
          {required final String groupName,
          required final List<ReferenceSubGroupModel> subgroups}) =
      _$_ReferenceGroupModel;

  factory _ReferenceGroupModel.fromJson(Map<String, dynamic> json) =
      _$_ReferenceGroupModel.fromJson;

  @override
  String get groupName;
  @override
  List<ReferenceSubGroupModel> get subgroups;
  @override
  @JsonKey(ignore: true)
  _$$_ReferenceGroupModelCopyWith<_$_ReferenceGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ReferenceSubGroupModel _$ReferenceSubGroupModelFromJson(
    Map<String, dynamic> json) {
  return _ReferenceSubGroupModel.fromJson(json);
}

/// @nodoc
mixin _$ReferenceSubGroupModel {
  String? get subgroupName => throw _privateConstructorUsedError;
  List<ReferenceTokenModel> get tokens => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferenceSubGroupModelCopyWith<ReferenceSubGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceSubGroupModelCopyWith<$Res> {
  factory $ReferenceSubGroupModelCopyWith(ReferenceSubGroupModel value,
          $Res Function(ReferenceSubGroupModel) then) =
      _$ReferenceSubGroupModelCopyWithImpl<$Res, ReferenceSubGroupModel>;
  @useResult
  $Res call({String? subgroupName, List<ReferenceTokenModel> tokens});
}

/// @nodoc
class _$ReferenceSubGroupModelCopyWithImpl<$Res,
        $Val extends ReferenceSubGroupModel>
    implements $ReferenceSubGroupModelCopyWith<$Res> {
  _$ReferenceSubGroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subgroupName = freezed,
    Object? tokens = null,
  }) {
    return _then(_value.copyWith(
      subgroupName: freezed == subgroupName
          ? _value.subgroupName
          : subgroupName // ignore: cast_nullable_to_non_nullable
              as String?,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<ReferenceTokenModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReferenceSubGroupModelCopyWith<$Res>
    implements $ReferenceSubGroupModelCopyWith<$Res> {
  factory _$$_ReferenceSubGroupModelCopyWith(_$_ReferenceSubGroupModel value,
          $Res Function(_$_ReferenceSubGroupModel) then) =
      __$$_ReferenceSubGroupModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? subgroupName, List<ReferenceTokenModel> tokens});
}

/// @nodoc
class __$$_ReferenceSubGroupModelCopyWithImpl<$Res>
    extends _$ReferenceSubGroupModelCopyWithImpl<$Res,
        _$_ReferenceSubGroupModel>
    implements _$$_ReferenceSubGroupModelCopyWith<$Res> {
  __$$_ReferenceSubGroupModelCopyWithImpl(_$_ReferenceSubGroupModel _value,
      $Res Function(_$_ReferenceSubGroupModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subgroupName = freezed,
    Object? tokens = null,
  }) {
    return _then(_$_ReferenceSubGroupModel(
      subgroupName: freezed == subgroupName
          ? _value.subgroupName
          : subgroupName // ignore: cast_nullable_to_non_nullable
              as String?,
      tokens: null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<ReferenceTokenModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReferenceSubGroupModel
    with DiagnosticableTreeMixin
    implements _ReferenceSubGroupModel {
  const _$_ReferenceSubGroupModel(
      {required this.subgroupName,
      required final List<ReferenceTokenModel> tokens})
      : _tokens = tokens;

  factory _$_ReferenceSubGroupModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReferenceSubGroupModelFromJson(json);

  @override
  final String? subgroupName;
  final List<ReferenceTokenModel> _tokens;
  @override
  List<ReferenceTokenModel> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReferenceSubGroupModel(subgroupName: $subgroupName, tokens: $tokens)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReferenceSubGroupModel'))
      ..add(DiagnosticsProperty('subgroupName', subgroupName))
      ..add(DiagnosticsProperty('tokens', tokens));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReferenceSubGroupModel &&
            (identical(other.subgroupName, subgroupName) ||
                other.subgroupName == subgroupName) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, subgroupName, const DeepCollectionEquality().hash(_tokens));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReferenceSubGroupModelCopyWith<_$_ReferenceSubGroupModel> get copyWith =>
      __$$_ReferenceSubGroupModelCopyWithImpl<_$_ReferenceSubGroupModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReferenceSubGroupModelToJson(
      this,
    );
  }
}

abstract class _ReferenceSubGroupModel implements ReferenceSubGroupModel {
  const factory _ReferenceSubGroupModel(
          {required final String? subgroupName,
          required final List<ReferenceTokenModel> tokens}) =
      _$_ReferenceSubGroupModel;

  factory _ReferenceSubGroupModel.fromJson(Map<String, dynamic> json) =
      _$_ReferenceSubGroupModel.fromJson;

  @override
  String? get subgroupName;
  @override
  List<ReferenceTokenModel> get tokens;
  @override
  @JsonKey(ignore: true)
  _$$_ReferenceSubGroupModelCopyWith<_$_ReferenceSubGroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ReferenceTokenModel _$ReferenceTokenModelFromJson(Map<String, dynamic> json) {
  return _ReferenceTokenModel.fromJson(json);
}

/// @nodoc
mixin _$ReferenceTokenModel {
  String get label => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get examples => throw _privateConstructorUsedError;
  String get href => throw _privateConstructorUsedError;
  String? get returns => throw _privateConstructorUsedError;
  List<String> get syntax => throw _privateConstructorUsedError;
  List<ReferenceTokenParam> get parameters =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferenceTokenModelCopyWith<ReferenceTokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceTokenModelCopyWith<$Res> {
  factory $ReferenceTokenModelCopyWith(
          ReferenceTokenModel value, $Res Function(ReferenceTokenModel) then) =
      _$ReferenceTokenModelCopyWithImpl<$Res, ReferenceTokenModel>;
  @useResult
  $Res call(
      {String label,
      String description,
      List<String> examples,
      String href,
      String? returns,
      List<String> syntax,
      List<ReferenceTokenParam> parameters});
}

/// @nodoc
class _$ReferenceTokenModelCopyWithImpl<$Res, $Val extends ReferenceTokenModel>
    implements $ReferenceTokenModelCopyWith<$Res> {
  _$ReferenceTokenModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? description = null,
    Object? examples = null,
    Object? href = null,
    Object? returns = freezed,
    Object? syntax = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<String>,
      href: null == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String,
      returns: freezed == returns
          ? _value.returns
          : returns // ignore: cast_nullable_to_non_nullable
              as String?,
      syntax: null == syntax
          ? _value.syntax
          : syntax // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ReferenceTokenParam>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReferenceTokenModelCopyWith<$Res>
    implements $ReferenceTokenModelCopyWith<$Res> {
  factory _$$_ReferenceTokenModelCopyWith(_$_ReferenceTokenModel value,
          $Res Function(_$_ReferenceTokenModel) then) =
      __$$_ReferenceTokenModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String label,
      String description,
      List<String> examples,
      String href,
      String? returns,
      List<String> syntax,
      List<ReferenceTokenParam> parameters});
}

/// @nodoc
class __$$_ReferenceTokenModelCopyWithImpl<$Res>
    extends _$ReferenceTokenModelCopyWithImpl<$Res, _$_ReferenceTokenModel>
    implements _$$_ReferenceTokenModelCopyWith<$Res> {
  __$$_ReferenceTokenModelCopyWithImpl(_$_ReferenceTokenModel _value,
      $Res Function(_$_ReferenceTokenModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? description = null,
    Object? examples = null,
    Object? href = null,
    Object? returns = freezed,
    Object? syntax = null,
    Object? parameters = null,
  }) {
    return _then(_$_ReferenceTokenModel(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value._examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<String>,
      href: null == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String,
      returns: freezed == returns
          ? _value.returns
          : returns // ignore: cast_nullable_to_non_nullable
              as String?,
      syntax: null == syntax
          ? _value._syntax
          : syntax // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ReferenceTokenParam>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReferenceTokenModel
    with DiagnosticableTreeMixin
    implements _ReferenceTokenModel {
  const _$_ReferenceTokenModel(
      {required this.label,
      required this.description,
      required final List<String> examples,
      required this.href,
      required this.returns,
      required final List<String> syntax,
      required final List<ReferenceTokenParam> parameters})
      : _examples = examples,
        _syntax = syntax,
        _parameters = parameters;

  factory _$_ReferenceTokenModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReferenceTokenModelFromJson(json);

  @override
  final String label;
  @override
  final String description;
  final List<String> _examples;
  @override
  List<String> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  final String href;
  @override
  final String? returns;
  final List<String> _syntax;
  @override
  List<String> get syntax {
    if (_syntax is EqualUnmodifiableListView) return _syntax;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_syntax);
  }

  final List<ReferenceTokenParam> _parameters;
  @override
  List<ReferenceTokenParam> get parameters {
    if (_parameters is EqualUnmodifiableListView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReferenceTokenModel(label: $label, description: $description, examples: $examples, href: $href, returns: $returns, syntax: $syntax, parameters: $parameters)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReferenceTokenModel'))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('examples', examples))
      ..add(DiagnosticsProperty('href', href))
      ..add(DiagnosticsProperty('returns', returns))
      ..add(DiagnosticsProperty('syntax', syntax))
      ..add(DiagnosticsProperty('parameters', parameters));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReferenceTokenModel &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._examples, _examples) &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.returns, returns) || other.returns == returns) &&
            const DeepCollectionEquality().equals(other._syntax, _syntax) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      label,
      description,
      const DeepCollectionEquality().hash(_examples),
      href,
      returns,
      const DeepCollectionEquality().hash(_syntax),
      const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReferenceTokenModelCopyWith<_$_ReferenceTokenModel> get copyWith =>
      __$$_ReferenceTokenModelCopyWithImpl<_$_ReferenceTokenModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReferenceTokenModelToJson(
      this,
    );
  }
}

abstract class _ReferenceTokenModel implements ReferenceTokenModel {
  const factory _ReferenceTokenModel(
          {required final String label,
          required final String description,
          required final List<String> examples,
          required final String href,
          required final String? returns,
          required final List<String> syntax,
          required final List<ReferenceTokenParam> parameters}) =
      _$_ReferenceTokenModel;

  factory _ReferenceTokenModel.fromJson(Map<String, dynamic> json) =
      _$_ReferenceTokenModel.fromJson;

  @override
  String get label;
  @override
  String get description;
  @override
  List<String> get examples;
  @override
  String get href;
  @override
  String? get returns;
  @override
  List<String> get syntax;
  @override
  List<ReferenceTokenParam> get parameters;
  @override
  @JsonKey(ignore: true)
  _$$_ReferenceTokenModelCopyWith<_$_ReferenceTokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ReferenceTokenParam _$ReferenceTokenParamFromJson(Map<String, dynamic> json) {
  return _ReferenceTokenParam.fromJson(json);
}

/// @nodoc
mixin _$ReferenceTokenParam {
  String get paramName => throw _privateConstructorUsedError;
  String get paramType => throw _privateConstructorUsedError;
  String get paramDescription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferenceTokenParamCopyWith<ReferenceTokenParam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceTokenParamCopyWith<$Res> {
  factory $ReferenceTokenParamCopyWith(
          ReferenceTokenParam value, $Res Function(ReferenceTokenParam) then) =
      _$ReferenceTokenParamCopyWithImpl<$Res, ReferenceTokenParam>;
  @useResult
  $Res call({String paramName, String paramType, String paramDescription});
}

/// @nodoc
class _$ReferenceTokenParamCopyWithImpl<$Res, $Val extends ReferenceTokenParam>
    implements $ReferenceTokenParamCopyWith<$Res> {
  _$ReferenceTokenParamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paramName = null,
    Object? paramType = null,
    Object? paramDescription = null,
  }) {
    return _then(_value.copyWith(
      paramName: null == paramName
          ? _value.paramName
          : paramName // ignore: cast_nullable_to_non_nullable
              as String,
      paramType: null == paramType
          ? _value.paramType
          : paramType // ignore: cast_nullable_to_non_nullable
              as String,
      paramDescription: null == paramDescription
          ? _value.paramDescription
          : paramDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReferenceTokenParamCopyWith<$Res>
    implements $ReferenceTokenParamCopyWith<$Res> {
  factory _$$_ReferenceTokenParamCopyWith(_$_ReferenceTokenParam value,
          $Res Function(_$_ReferenceTokenParam) then) =
      __$$_ReferenceTokenParamCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String paramName, String paramType, String paramDescription});
}

/// @nodoc
class __$$_ReferenceTokenParamCopyWithImpl<$Res>
    extends _$ReferenceTokenParamCopyWithImpl<$Res, _$_ReferenceTokenParam>
    implements _$$_ReferenceTokenParamCopyWith<$Res> {
  __$$_ReferenceTokenParamCopyWithImpl(_$_ReferenceTokenParam _value,
      $Res Function(_$_ReferenceTokenParam) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paramName = null,
    Object? paramType = null,
    Object? paramDescription = null,
  }) {
    return _then(_$_ReferenceTokenParam(
      paramName: null == paramName
          ? _value.paramName
          : paramName // ignore: cast_nullable_to_non_nullable
              as String,
      paramType: null == paramType
          ? _value.paramType
          : paramType // ignore: cast_nullable_to_non_nullable
              as String,
      paramDescription: null == paramDescription
          ? _value.paramDescription
          : paramDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReferenceTokenParam
    with DiagnosticableTreeMixin
    implements _ReferenceTokenParam {
  const _$_ReferenceTokenParam(
      {required this.paramName,
      required this.paramType,
      required this.paramDescription});

  factory _$_ReferenceTokenParam.fromJson(Map<String, dynamic> json) =>
      _$$_ReferenceTokenParamFromJson(json);

  @override
  final String paramName;
  @override
  final String paramType;
  @override
  final String paramDescription;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReferenceTokenParam(paramName: $paramName, paramType: $paramType, paramDescription: $paramDescription)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReferenceTokenParam'))
      ..add(DiagnosticsProperty('paramName', paramName))
      ..add(DiagnosticsProperty('paramType', paramType))
      ..add(DiagnosticsProperty('paramDescription', paramDescription));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReferenceTokenParam &&
            (identical(other.paramName, paramName) ||
                other.paramName == paramName) &&
            (identical(other.paramType, paramType) ||
                other.paramType == paramType) &&
            (identical(other.paramDescription, paramDescription) ||
                other.paramDescription == paramDescription));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, paramName, paramType, paramDescription);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReferenceTokenParamCopyWith<_$_ReferenceTokenParam> get copyWith =>
      __$$_ReferenceTokenParamCopyWithImpl<_$_ReferenceTokenParam>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReferenceTokenParamToJson(
      this,
    );
  }
}

abstract class _ReferenceTokenParam implements ReferenceTokenParam {
  const factory _ReferenceTokenParam(
      {required final String paramName,
      required final String paramType,
      required final String paramDescription}) = _$_ReferenceTokenParam;

  factory _ReferenceTokenParam.fromJson(Map<String, dynamic> json) =
      _$_ReferenceTokenParam.fromJson;

  @override
  String get paramName;
  @override
  String get paramType;
  @override
  String get paramDescription;
  @override
  @JsonKey(ignore: true)
  _$$_ReferenceTokenParamCopyWith<_$_ReferenceTokenParam> get copyWith =>
      throw _privateConstructorUsedError;
}
