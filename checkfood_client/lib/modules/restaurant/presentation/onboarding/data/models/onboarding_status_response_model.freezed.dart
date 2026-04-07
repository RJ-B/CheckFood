// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_status_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OnboardingStatusResponseModel _$OnboardingStatusResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _OnboardingStatusResponseModel.fromJson(json);
}

/// @nodoc
mixin _$OnboardingStatusResponseModel {
  bool get onboardingCompleted => throw _privateConstructorUsedError;
  bool get hasInfo => throw _privateConstructorUsedError;
  bool get hasHours => throw _privateConstructorUsedError;
  bool get hasTables => throw _privateConstructorUsedError;
  bool get hasMenu => throw _privateConstructorUsedError;
  bool get hasPanorama => throw _privateConstructorUsedError;

  /// Serializes this OnboardingStatusResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingStatusResponseModelCopyWith<OnboardingStatusResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStatusResponseModelCopyWith<$Res> {
  factory $OnboardingStatusResponseModelCopyWith(
    OnboardingStatusResponseModel value,
    $Res Function(OnboardingStatusResponseModel) then,
  ) =
      _$OnboardingStatusResponseModelCopyWithImpl<
        $Res,
        OnboardingStatusResponseModel
      >;
  @useResult
  $Res call({
    bool onboardingCompleted,
    bool hasInfo,
    bool hasHours,
    bool hasTables,
    bool hasMenu,
    bool hasPanorama,
  });
}

/// @nodoc
class _$OnboardingStatusResponseModelCopyWithImpl<
  $Res,
  $Val extends OnboardingStatusResponseModel
>
    implements $OnboardingStatusResponseModelCopyWith<$Res> {
  _$OnboardingStatusResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onboardingCompleted = null,
    Object? hasInfo = null,
    Object? hasHours = null,
    Object? hasTables = null,
    Object? hasMenu = null,
    Object? hasPanorama = null,
  }) {
    return _then(
      _value.copyWith(
            onboardingCompleted:
                null == onboardingCompleted
                    ? _value.onboardingCompleted
                    : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasInfo:
                null == hasInfo
                    ? _value.hasInfo
                    : hasInfo // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasHours:
                null == hasHours
                    ? _value.hasHours
                    : hasHours // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasTables:
                null == hasTables
                    ? _value.hasTables
                    : hasTables // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasMenu:
                null == hasMenu
                    ? _value.hasMenu
                    : hasMenu // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasPanorama:
                null == hasPanorama
                    ? _value.hasPanorama
                    : hasPanorama // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingStatusResponseModelImplCopyWith<$Res>
    implements $OnboardingStatusResponseModelCopyWith<$Res> {
  factory _$$OnboardingStatusResponseModelImplCopyWith(
    _$OnboardingStatusResponseModelImpl value,
    $Res Function(_$OnboardingStatusResponseModelImpl) then,
  ) = __$$OnboardingStatusResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool onboardingCompleted,
    bool hasInfo,
    bool hasHours,
    bool hasTables,
    bool hasMenu,
    bool hasPanorama,
  });
}

/// @nodoc
class __$$OnboardingStatusResponseModelImplCopyWithImpl<$Res>
    extends
        _$OnboardingStatusResponseModelCopyWithImpl<
          $Res,
          _$OnboardingStatusResponseModelImpl
        >
    implements _$$OnboardingStatusResponseModelImplCopyWith<$Res> {
  __$$OnboardingStatusResponseModelImplCopyWithImpl(
    _$OnboardingStatusResponseModelImpl _value,
    $Res Function(_$OnboardingStatusResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onboardingCompleted = null,
    Object? hasInfo = null,
    Object? hasHours = null,
    Object? hasTables = null,
    Object? hasMenu = null,
    Object? hasPanorama = null,
  }) {
    return _then(
      _$OnboardingStatusResponseModelImpl(
        onboardingCompleted:
            null == onboardingCompleted
                ? _value.onboardingCompleted
                : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasInfo:
            null == hasInfo
                ? _value.hasInfo
                : hasInfo // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasHours:
            null == hasHours
                ? _value.hasHours
                : hasHours // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasTables:
            null == hasTables
                ? _value.hasTables
                : hasTables // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasMenu:
            null == hasMenu
                ? _value.hasMenu
                : hasMenu // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasPanorama:
            null == hasPanorama
                ? _value.hasPanorama
                : hasPanorama // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingStatusResponseModelImpl
    extends _OnboardingStatusResponseModel {
  const _$OnboardingStatusResponseModelImpl({
    this.onboardingCompleted = false,
    this.hasInfo = false,
    this.hasHours = false,
    this.hasTables = false,
    this.hasMenu = false,
    this.hasPanorama = false,
  }) : super._();

  factory _$OnboardingStatusResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$OnboardingStatusResponseModelImplFromJson(json);

  @override
  @JsonKey()
  final bool onboardingCompleted;
  @override
  @JsonKey()
  final bool hasInfo;
  @override
  @JsonKey()
  final bool hasHours;
  @override
  @JsonKey()
  final bool hasTables;
  @override
  @JsonKey()
  final bool hasMenu;
  @override
  @JsonKey()
  final bool hasPanorama;

  @override
  String toString() {
    return 'OnboardingStatusResponseModel(onboardingCompleted: $onboardingCompleted, hasInfo: $hasInfo, hasHours: $hasHours, hasTables: $hasTables, hasMenu: $hasMenu, hasPanorama: $hasPanorama)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStatusResponseModelImpl &&
            (identical(other.onboardingCompleted, onboardingCompleted) ||
                other.onboardingCompleted == onboardingCompleted) &&
            (identical(other.hasInfo, hasInfo) || other.hasInfo == hasInfo) &&
            (identical(other.hasHours, hasHours) ||
                other.hasHours == hasHours) &&
            (identical(other.hasTables, hasTables) ||
                other.hasTables == hasTables) &&
            (identical(other.hasMenu, hasMenu) || other.hasMenu == hasMenu) &&
            (identical(other.hasPanorama, hasPanorama) ||
                other.hasPanorama == hasPanorama));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    onboardingCompleted,
    hasInfo,
    hasHours,
    hasTables,
    hasMenu,
    hasPanorama,
  );

  /// Create a copy of OnboardingStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStatusResponseModelImplCopyWith<
    _$OnboardingStatusResponseModelImpl
  >
  get copyWith => __$$OnboardingStatusResponseModelImplCopyWithImpl<
    _$OnboardingStatusResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingStatusResponseModelImplToJson(this);
  }
}

abstract class _OnboardingStatusResponseModel
    extends OnboardingStatusResponseModel {
  const factory _OnboardingStatusResponseModel({
    final bool onboardingCompleted,
    final bool hasInfo,
    final bool hasHours,
    final bool hasTables,
    final bool hasMenu,
    final bool hasPanorama,
  }) = _$OnboardingStatusResponseModelImpl;
  const _OnboardingStatusResponseModel._() : super._();

  factory _OnboardingStatusResponseModel.fromJson(Map<String, dynamic> json) =
      _$OnboardingStatusResponseModelImpl.fromJson;

  @override
  bool get onboardingCompleted;
  @override
  bool get hasInfo;
  @override
  bool get hasHours;
  @override
  bool get hasTables;
  @override
  bool get hasMenu;
  @override
  bool get hasPanorama;

  /// Create a copy of OnboardingStatusResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingStatusResponseModelImplCopyWith<
    _$OnboardingStatusResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
