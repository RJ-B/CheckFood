// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opening_hours.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OpeningHours {
  int get dayOfWeek =>
      throw _privateConstructorUsedError; // 1 (pondělí) až 7 (neděle)
  String? get openAt =>
      throw _privateConstructorUsedError; // formát "HH:mm:ss" nebo "HH:mm"
  String? get closeAt => throw _privateConstructorUsedError;
  bool get isClosed => throw _privateConstructorUsedError;

  /// Create a copy of OpeningHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpeningHoursCopyWith<OpeningHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpeningHoursCopyWith<$Res> {
  factory $OpeningHoursCopyWith(
    OpeningHours value,
    $Res Function(OpeningHours) then,
  ) = _$OpeningHoursCopyWithImpl<$Res, OpeningHours>;
  @useResult
  $Res call({int dayOfWeek, String? openAt, String? closeAt, bool isClosed});
}

/// @nodoc
class _$OpeningHoursCopyWithImpl<$Res, $Val extends OpeningHours>
    implements $OpeningHoursCopyWith<$Res> {
  _$OpeningHoursCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpeningHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOfWeek = null,
    Object? openAt = freezed,
    Object? closeAt = freezed,
    Object? isClosed = null,
  }) {
    return _then(
      _value.copyWith(
            dayOfWeek:
                null == dayOfWeek
                    ? _value.dayOfWeek
                    : dayOfWeek // ignore: cast_nullable_to_non_nullable
                        as int,
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
abstract class _$$OpeningHoursImplCopyWith<$Res>
    implements $OpeningHoursCopyWith<$Res> {
  factory _$$OpeningHoursImplCopyWith(
    _$OpeningHoursImpl value,
    $Res Function(_$OpeningHoursImpl) then,
  ) = __$$OpeningHoursImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int dayOfWeek, String? openAt, String? closeAt, bool isClosed});
}

/// @nodoc
class __$$OpeningHoursImplCopyWithImpl<$Res>
    extends _$OpeningHoursCopyWithImpl<$Res, _$OpeningHoursImpl>
    implements _$$OpeningHoursImplCopyWith<$Res> {
  __$$OpeningHoursImplCopyWithImpl(
    _$OpeningHoursImpl _value,
    $Res Function(_$OpeningHoursImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OpeningHours
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOfWeek = null,
    Object? openAt = freezed,
    Object? closeAt = freezed,
    Object? isClosed = null,
  }) {
    return _then(
      _$OpeningHoursImpl(
        dayOfWeek:
            null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                    as int,
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

class _$OpeningHoursImpl extends _OpeningHours {
  const _$OpeningHoursImpl({
    required this.dayOfWeek,
    this.openAt,
    this.closeAt,
    required this.isClosed,
  }) : super._();

  @override
  final int dayOfWeek;
  // 1 (pondělí) až 7 (neděle)
  @override
  final String? openAt;
  // formát "HH:mm:ss" nebo "HH:mm"
  @override
  final String? closeAt;
  @override
  final bool isClosed;

  @override
  String toString() {
    return 'OpeningHours(dayOfWeek: $dayOfWeek, openAt: $openAt, closeAt: $closeAt, isClosed: $isClosed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpeningHoursImpl &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.openAt, openAt) || other.openAt == openAt) &&
            (identical(other.closeAt, closeAt) || other.closeAt == closeAt) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, dayOfWeek, openAt, closeAt, isClosed);

  /// Create a copy of OpeningHours
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpeningHoursImplCopyWith<_$OpeningHoursImpl> get copyWith =>
      __$$OpeningHoursImplCopyWithImpl<_$OpeningHoursImpl>(this, _$identity);
}

abstract class _OpeningHours extends OpeningHours {
  const factory _OpeningHours({
    required final int dayOfWeek,
    final String? openAt,
    final String? closeAt,
    required final bool isClosed,
  }) = _$OpeningHoursImpl;
  const _OpeningHours._() : super._();

  @override
  int get dayOfWeek; // 1 (pondělí) až 7 (neděle)
  @override
  String? get openAt; // formát "HH:mm:ss" nebo "HH:mm"
  @override
  String? get closeAt;
  @override
  bool get isClosed;

  /// Create a copy of OpeningHours
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpeningHoursImplCopyWith<_$OpeningHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
