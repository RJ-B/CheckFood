// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_hours_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OnboardingHoursRequestModel _$OnboardingHoursRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _OnboardingHoursRequestModel.fromJson(json);
}

/// @nodoc
mixin _$OnboardingHoursRequestModel {
  List<OpeningHoursModel> get openingHours =>
      throw _privateConstructorUsedError;

  /// Serializes this OnboardingHoursRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingHoursRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingHoursRequestModelCopyWith<OnboardingHoursRequestModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingHoursRequestModelCopyWith<$Res> {
  factory $OnboardingHoursRequestModelCopyWith(
    OnboardingHoursRequestModel value,
    $Res Function(OnboardingHoursRequestModel) then,
  ) =
      _$OnboardingHoursRequestModelCopyWithImpl<
        $Res,
        OnboardingHoursRequestModel
      >;
  @useResult
  $Res call({List<OpeningHoursModel> openingHours});
}

/// @nodoc
class _$OnboardingHoursRequestModelCopyWithImpl<
  $Res,
  $Val extends OnboardingHoursRequestModel
>
    implements $OnboardingHoursRequestModelCopyWith<$Res> {
  _$OnboardingHoursRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingHoursRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? openingHours = null}) {
    return _then(
      _value.copyWith(
            openingHours:
                null == openingHours
                    ? _value.openingHours
                    : openingHours // ignore: cast_nullable_to_non_nullable
                        as List<OpeningHoursModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingHoursRequestModelImplCopyWith<$Res>
    implements $OnboardingHoursRequestModelCopyWith<$Res> {
  factory _$$OnboardingHoursRequestModelImplCopyWith(
    _$OnboardingHoursRequestModelImpl value,
    $Res Function(_$OnboardingHoursRequestModelImpl) then,
  ) = __$$OnboardingHoursRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OpeningHoursModel> openingHours});
}

/// @nodoc
class __$$OnboardingHoursRequestModelImplCopyWithImpl<$Res>
    extends
        _$OnboardingHoursRequestModelCopyWithImpl<
          $Res,
          _$OnboardingHoursRequestModelImpl
        >
    implements _$$OnboardingHoursRequestModelImplCopyWith<$Res> {
  __$$OnboardingHoursRequestModelImplCopyWithImpl(
    _$OnboardingHoursRequestModelImpl _value,
    $Res Function(_$OnboardingHoursRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingHoursRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? openingHours = null}) {
    return _then(
      _$OnboardingHoursRequestModelImpl(
        openingHours:
            null == openingHours
                ? _value._openingHours
                : openingHours // ignore: cast_nullable_to_non_nullable
                    as List<OpeningHoursModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingHoursRequestModelImpl
    implements _OnboardingHoursRequestModel {
  const _$OnboardingHoursRequestModelImpl({
    required final List<OpeningHoursModel> openingHours,
  }) : _openingHours = openingHours;

  factory _$OnboardingHoursRequestModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$OnboardingHoursRequestModelImplFromJson(json);

  final List<OpeningHoursModel> _openingHours;
  @override
  List<OpeningHoursModel> get openingHours {
    if (_openingHours is EqualUnmodifiableListView) return _openingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openingHours);
  }

  @override
  String toString() {
    return 'OnboardingHoursRequestModel(openingHours: $openingHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingHoursRequestModelImpl &&
            const DeepCollectionEquality().equals(
              other._openingHours,
              _openingHours,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_openingHours),
  );

  /// Create a copy of OnboardingHoursRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingHoursRequestModelImplCopyWith<_$OnboardingHoursRequestModelImpl>
  get copyWith => __$$OnboardingHoursRequestModelImplCopyWithImpl<
    _$OnboardingHoursRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingHoursRequestModelImplToJson(this);
  }
}

abstract class _OnboardingHoursRequestModel
    implements OnboardingHoursRequestModel {
  const factory _OnboardingHoursRequestModel({
    required final List<OpeningHoursModel> openingHours,
  }) = _$OnboardingHoursRequestModelImpl;

  factory _OnboardingHoursRequestModel.fromJson(Map<String, dynamic> json) =
      _$OnboardingHoursRequestModelImpl.fromJson;

  @override
  List<OpeningHoursModel> get openingHours;

  /// Create a copy of OnboardingHoursRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingHoursRequestModelImplCopyWith<_$OnboardingHoursRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
