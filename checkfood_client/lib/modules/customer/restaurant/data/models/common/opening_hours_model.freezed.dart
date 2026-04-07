// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opening_hours_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OpeningHoursModel _$OpeningHoursModelFromJson(Map<String, dynamic> json) {
  return _OpeningHoursModel.fromJson(json);
}

/// @nodoc
mixin _$OpeningHoursModel {
  @JsonKey(name: 'dayOfWeek')
  String get dayString => throw _privateConstructorUsedError;
  String? get openAt => throw _privateConstructorUsedError;
  String? get closeAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed')
  bool get isClosed => throw _privateConstructorUsedError;

  /// Serializes this OpeningHoursModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpeningHoursModelCopyWith<OpeningHoursModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpeningHoursModelCopyWith<$Res> {
  factory $OpeningHoursModelCopyWith(
    OpeningHoursModel value,
    $Res Function(OpeningHoursModel) then,
  ) = _$OpeningHoursModelCopyWithImpl<$Res, OpeningHoursModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'dayOfWeek') String dayString,
    String? openAt,
    String? closeAt,
    @JsonKey(name: 'closed') bool isClosed,
  });
}

/// @nodoc
class _$OpeningHoursModelCopyWithImpl<$Res, $Val extends OpeningHoursModel>
    implements $OpeningHoursModelCopyWith<$Res> {
  _$OpeningHoursModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayString = null,
    Object? openAt = freezed,
    Object? closeAt = freezed,
    Object? isClosed = null,
  }) {
    return _then(
      _value.copyWith(
            dayString:
                null == dayString
                    ? _value.dayString
                    : dayString // ignore: cast_nullable_to_non_nullable
                        as String,
            openAt:
                freezed == openAt
                    ? _value.openAt
                    : openAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            closeAt:
                freezed == closeAt
                    ? _value.closeAt
                    : closeAt // ignore: cast_nullable_to_non_nullable
                        as String?,
            isClosed:
                null == isClosed
                    ? _value.isClosed
                    : isClosed // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OpeningHoursModelImplCopyWith<$Res>
    implements $OpeningHoursModelCopyWith<$Res> {
  factory _$$OpeningHoursModelImplCopyWith(
    _$OpeningHoursModelImpl value,
    $Res Function(_$OpeningHoursModelImpl) then,
  ) = __$$OpeningHoursModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'dayOfWeek') String dayString,
    String? openAt,
    String? closeAt,
    @JsonKey(name: 'closed') bool isClosed,
  });
}

/// @nodoc
class __$$OpeningHoursModelImplCopyWithImpl<$Res>
    extends _$OpeningHoursModelCopyWithImpl<$Res, _$OpeningHoursModelImpl>
    implements _$$OpeningHoursModelImplCopyWith<$Res> {
  __$$OpeningHoursModelImplCopyWithImpl(
    _$OpeningHoursModelImpl _value,
    $Res Function(_$OpeningHoursModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayString = null,
    Object? openAt = freezed,
    Object? closeAt = freezed,
    Object? isClosed = null,
  }) {
    return _then(
      _$OpeningHoursModelImpl(
        dayString:
            null == dayString
                ? _value.dayString
                : dayString // ignore: cast_nullable_to_non_nullable
                    as String,
        openAt:
            freezed == openAt
                ? _value.openAt
                : openAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        closeAt:
            freezed == closeAt
                ? _value.closeAt
                : closeAt // ignore: cast_nullable_to_non_nullable
                    as String?,
        isClosed:
            null == isClosed
                ? _value.isClosed
                : isClosed // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OpeningHoursModelImpl extends _OpeningHoursModel {
  const _$OpeningHoursModelImpl({
    @JsonKey(name: 'dayOfWeek') required this.dayString,
    this.openAt,
    this.closeAt,
    @JsonKey(name: 'closed') required this.isClosed,
  }) : super._();

  factory _$OpeningHoursModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpeningHoursModelImplFromJson(json);

  @override
  @JsonKey(name: 'dayOfWeek')
  final String dayString;
  @override
  final String? openAt;
  @override
  final String? closeAt;
  @override
  @JsonKey(name: 'closed')
  final bool isClosed;

  @override
  String toString() {
    return 'OpeningHoursModel(dayString: $dayString, openAt: $openAt, closeAt: $closeAt, isClosed: $isClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpeningHoursModelImpl &&
            (identical(other.dayString, dayString) ||
                other.dayString == dayString) &&
            (identical(other.openAt, openAt) || other.openAt == openAt) &&
            (identical(other.closeAt, closeAt) || other.closeAt == closeAt) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, dayString, openAt, closeAt, isClosed);

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpeningHoursModelImplCopyWith<_$OpeningHoursModelImpl> get copyWith =>
      __$$OpeningHoursModelImplCopyWithImpl<_$OpeningHoursModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OpeningHoursModelImplToJson(this);
  }
}

abstract class _OpeningHoursModel extends OpeningHoursModel {
  const factory _OpeningHoursModel({
    @JsonKey(name: 'dayOfWeek') required final String dayString,
    final String? openAt,
    final String? closeAt,
    @JsonKey(name: 'closed') required final bool isClosed,
  }) = _$OpeningHoursModelImpl;
  const _OpeningHoursModel._() : super._();

  factory _OpeningHoursModel.fromJson(Map<String, dynamic> json) =
      _$OpeningHoursModelImpl.fromJson;

  @override
  @JsonKey(name: 'dayOfWeek')
  String get dayString;
  @override
  String? get openAt;
  @override
  String? get closeAt;
  @override
  @JsonKey(name: 'closed')
  bool get isClosed;

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpeningHoursModelImplCopyWith<_$OpeningHoursModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
