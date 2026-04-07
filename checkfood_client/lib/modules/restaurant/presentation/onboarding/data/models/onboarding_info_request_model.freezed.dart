// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_info_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OnboardingInfoRequestModel _$OnboardingInfoRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _OnboardingInfoRequestModel.fromJson(json);
}

/// @nodoc
mixin _$OnboardingInfoRequestModel {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  AddressModel? get address => throw _privateConstructorUsedError;
  String? get cuisineType => throw _privateConstructorUsedError;

  /// Serializes this OnboardingInfoRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingInfoRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingInfoRequestModelCopyWith<OnboardingInfoRequestModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingInfoRequestModelCopyWith<$Res> {
  factory $OnboardingInfoRequestModelCopyWith(
    OnboardingInfoRequestModel value,
    $Res Function(OnboardingInfoRequestModel) then,
  ) =
      _$OnboardingInfoRequestModelCopyWithImpl<
        $Res,
        OnboardingInfoRequestModel
      >;
  @useResult
  $Res call({
    String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  });

  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class _$OnboardingInfoRequestModelCopyWithImpl<
  $Res,
  $Val extends OnboardingInfoRequestModel
>
    implements $OnboardingInfoRequestModelCopyWith<$Res> {
  _$OnboardingInfoRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingInfoRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? cuisineType = freezed,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            address:
                freezed == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as AddressModel?,
            cuisineType:
                freezed == cuisineType
                    ? _value.cuisineType
                    : cuisineType // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of OnboardingInfoRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OnboardingInfoRequestModelImplCopyWith<$Res>
    implements $OnboardingInfoRequestModelCopyWith<$Res> {
  factory _$$OnboardingInfoRequestModelImplCopyWith(
    _$OnboardingInfoRequestModelImpl value,
    $Res Function(_$OnboardingInfoRequestModelImpl) then,
  ) = __$$OnboardingInfoRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  });

  @override
  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class __$$OnboardingInfoRequestModelImplCopyWithImpl<$Res>
    extends
        _$OnboardingInfoRequestModelCopyWithImpl<
          $Res,
          _$OnboardingInfoRequestModelImpl
        >
    implements _$$OnboardingInfoRequestModelImplCopyWith<$Res> {
  __$$OnboardingInfoRequestModelImplCopyWithImpl(
    _$OnboardingInfoRequestModelImpl _value,
    $Res Function(_$OnboardingInfoRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingInfoRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? cuisineType = freezed,
  }) {
    return _then(
      _$OnboardingInfoRequestModelImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        address:
            freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as AddressModel?,
        cuisineType:
            freezed == cuisineType
                ? _value.cuisineType
                : cuisineType // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingInfoRequestModelImpl implements _OnboardingInfoRequestModel {
  const _$OnboardingInfoRequestModelImpl({
    required this.name,
    this.description,
    this.phone,
    this.email,
    this.address,
    this.cuisineType,
  });

  factory _$OnboardingInfoRequestModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$OnboardingInfoRequestModelImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final AddressModel? address;
  @override
  final String? cuisineType;

  @override
  String toString() {
    return 'OnboardingInfoRequestModel(name: $name, description: $description, phone: $phone, email: $email, address: $address, cuisineType: $cuisineType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingInfoRequestModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.cuisineType, cuisineType) ||
                other.cuisineType == cuisineType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    description,
    phone,
    email,
    address,
    cuisineType,
  );

  /// Create a copy of OnboardingInfoRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingInfoRequestModelImplCopyWith<_$OnboardingInfoRequestModelImpl>
  get copyWith => __$$OnboardingInfoRequestModelImplCopyWithImpl<
    _$OnboardingInfoRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingInfoRequestModelImplToJson(this);
  }
}

abstract class _OnboardingInfoRequestModel
    implements OnboardingInfoRequestModel {
  const factory _OnboardingInfoRequestModel({
    required final String name,
    final String? description,
    final String? phone,
    final String? email,
    final AddressModel? address,
    final String? cuisineType,
  }) = _$OnboardingInfoRequestModelImpl;

  factory _OnboardingInfoRequestModel.fromJson(Map<String, dynamic> json) =
      _$OnboardingInfoRequestModelImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  AddressModel? get address;
  @override
  String? get cuisineType;

  /// Create a copy of OnboardingInfoRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingInfoRequestModelImplCopyWith<_$OnboardingInfoRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
