// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_profile_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdateProfileRequestModel _$UpdateProfileRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateProfileRequestModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfileRequestModel {
  @JsonKey(name: SecurityJsonKeys.firstName)
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.lastName)
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: SecurityJsonKeys.profileImageUrl)
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'addressStreet')
  String? get addressStreet => throw _privateConstructorUsedError;
  @JsonKey(name: 'addressCity')
  String? get addressCity => throw _privateConstructorUsedError;
  @JsonKey(name: 'addressPostalCode')
  String? get addressPostalCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'addressCountry')
  String? get addressCountry => throw _privateConstructorUsedError;

  /// Serializes this UpdateProfileRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProfileRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProfileRequestModelCopyWith<UpdateProfileRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileRequestModelCopyWith<$Res> {
  factory $UpdateProfileRequestModelCopyWith(
    UpdateProfileRequestModel value,
    $Res Function(UpdateProfileRequestModel) then,
  ) = _$UpdateProfileRequestModelCopyWithImpl<$Res, UpdateProfileRequestModel>;
  @useResult
  $Res call({
    @JsonKey(name: SecurityJsonKeys.firstName) String firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) String lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) String? profileImageUrl,
    String? phone,
    @JsonKey(name: 'addressStreet') String? addressStreet,
    @JsonKey(name: 'addressCity') String? addressCity,
    @JsonKey(name: 'addressPostalCode') String? addressPostalCode,
    @JsonKey(name: 'addressCountry') String? addressCountry,
  });
}

/// @nodoc
class _$UpdateProfileRequestModelCopyWithImpl<
  $Res,
  $Val extends UpdateProfileRequestModel
>
    implements $UpdateProfileRequestModelCopyWith<$Res> {
  _$UpdateProfileRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProfileRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? profileImageUrl = freezed,
    Object? phone = freezed,
    Object? addressStreet = freezed,
    Object? addressCity = freezed,
    Object? addressPostalCode = freezed,
    Object? addressCountry = freezed,
  }) {
    return _then(
      _value.copyWith(
            firstName:
                null == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String,
            lastName:
                null == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String,
            profileImageUrl:
                freezed == profileImageUrl
                    ? _value.profileImageUrl
                    : profileImageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
            addressStreet:
                freezed == addressStreet
                    ? _value.addressStreet
                    : addressStreet // ignore: cast_nullable_to_non_nullable
                        as String?,
            addressCity:
                freezed == addressCity
                    ? _value.addressCity
                    : addressCity // ignore: cast_nullable_to_non_nullable
                        as String?,
            addressPostalCode:
                freezed == addressPostalCode
                    ? _value.addressPostalCode
                    : addressPostalCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            addressCountry:
                freezed == addressCountry
                    ? _value.addressCountry
                    : addressCountry // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateProfileRequestModelImplCopyWith<$Res>
    implements $UpdateProfileRequestModelCopyWith<$Res> {
  factory _$$UpdateProfileRequestModelImplCopyWith(
    _$UpdateProfileRequestModelImpl value,
    $Res Function(_$UpdateProfileRequestModelImpl) then,
  ) = __$$UpdateProfileRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: SecurityJsonKeys.firstName) String firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) String lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) String? profileImageUrl,
    String? phone,
    @JsonKey(name: 'addressStreet') String? addressStreet,
    @JsonKey(name: 'addressCity') String? addressCity,
    @JsonKey(name: 'addressPostalCode') String? addressPostalCode,
    @JsonKey(name: 'addressCountry') String? addressCountry,
  });
}

/// @nodoc
class __$$UpdateProfileRequestModelImplCopyWithImpl<$Res>
    extends
        _$UpdateProfileRequestModelCopyWithImpl<
          $Res,
          _$UpdateProfileRequestModelImpl
        >
    implements _$$UpdateProfileRequestModelImplCopyWith<$Res> {
  __$$UpdateProfileRequestModelImplCopyWithImpl(
    _$UpdateProfileRequestModelImpl _value,
    $Res Function(_$UpdateProfileRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateProfileRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? profileImageUrl = freezed,
    Object? phone = freezed,
    Object? addressStreet = freezed,
    Object? addressCity = freezed,
    Object? addressPostalCode = freezed,
    Object? addressCountry = freezed,
  }) {
    return _then(
      _$UpdateProfileRequestModelImpl(
        firstName:
            null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String,
        lastName:
            null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String,
        profileImageUrl:
            freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        addressStreet:
            freezed == addressStreet
                ? _value.addressStreet
                : addressStreet // ignore: cast_nullable_to_non_nullable
                    as String?,
        addressCity:
            freezed == addressCity
                ? _value.addressCity
                : addressCity // ignore: cast_nullable_to_non_nullable
                    as String?,
        addressPostalCode:
            freezed == addressPostalCode
                ? _value.addressPostalCode
                : addressPostalCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        addressCountry:
            freezed == addressCountry
                ? _value.addressCountry
                : addressCountry // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfileRequestModelImpl implements _UpdateProfileRequestModel {
  const _$UpdateProfileRequestModelImpl({
    @JsonKey(name: SecurityJsonKeys.firstName) required this.firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) required this.lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl) this.profileImageUrl,
    this.phone,
    @JsonKey(name: 'addressStreet') this.addressStreet,
    @JsonKey(name: 'addressCity') this.addressCity,
    @JsonKey(name: 'addressPostalCode') this.addressPostalCode,
    @JsonKey(name: 'addressCountry') this.addressCountry,
  });

  factory _$UpdateProfileRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfileRequestModelImplFromJson(json);

  @override
  @JsonKey(name: SecurityJsonKeys.firstName)
  final String firstName;
  @override
  @JsonKey(name: SecurityJsonKeys.lastName)
  final String lastName;
  @override
  @JsonKey(name: SecurityJsonKeys.profileImageUrl)
  final String? profileImageUrl;
  @override
  final String? phone;
  @override
  @JsonKey(name: 'addressStreet')
  final String? addressStreet;
  @override
  @JsonKey(name: 'addressCity')
  final String? addressCity;
  @override
  @JsonKey(name: 'addressPostalCode')
  final String? addressPostalCode;
  @override
  @JsonKey(name: 'addressCountry')
  final String? addressCountry;

  @override
  String toString() {
    return 'UpdateProfileRequestModel(firstName: $firstName, lastName: $lastName, profileImageUrl: $profileImageUrl, phone: $phone, addressStreet: $addressStreet, addressCity: $addressCity, addressPostalCode: $addressPostalCode, addressCountry: $addressCountry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestModelImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.addressStreet, addressStreet) ||
                other.addressStreet == addressStreet) &&
            (identical(other.addressCity, addressCity) ||
                other.addressCity == addressCity) &&
            (identical(other.addressPostalCode, addressPostalCode) ||
                other.addressPostalCode == addressPostalCode) &&
            (identical(other.addressCountry, addressCountry) ||
                other.addressCountry == addressCountry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstName,
    lastName,
    profileImageUrl,
    phone,
    addressStreet,
    addressCity,
    addressPostalCode,
    addressCountry,
  );

  /// Create a copy of UpdateProfileRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestModelImplCopyWith<_$UpdateProfileRequestModelImpl>
  get copyWith => __$$UpdateProfileRequestModelImplCopyWithImpl<
    _$UpdateProfileRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfileRequestModelImplToJson(this);
  }
}

abstract class _UpdateProfileRequestModel implements UpdateProfileRequestModel {
  const factory _UpdateProfileRequestModel({
    @JsonKey(name: SecurityJsonKeys.firstName) required final String firstName,
    @JsonKey(name: SecurityJsonKeys.lastName) required final String lastName,
    @JsonKey(name: SecurityJsonKeys.profileImageUrl)
    final String? profileImageUrl,
    final String? phone,
    @JsonKey(name: 'addressStreet') final String? addressStreet,
    @JsonKey(name: 'addressCity') final String? addressCity,
    @JsonKey(name: 'addressPostalCode') final String? addressPostalCode,
    @JsonKey(name: 'addressCountry') final String? addressCountry,
  }) = _$UpdateProfileRequestModelImpl;

  factory _UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) =
      _$UpdateProfileRequestModelImpl.fromJson;

  @override
  @JsonKey(name: SecurityJsonKeys.firstName)
  String get firstName;
  @override
  @JsonKey(name: SecurityJsonKeys.lastName)
  String get lastName;
  @override
  @JsonKey(name: SecurityJsonKeys.profileImageUrl)
  String? get profileImageUrl;
  @override
  String? get phone;
  @override
  @JsonKey(name: 'addressStreet')
  String? get addressStreet;
  @override
  @JsonKey(name: 'addressCity')
  String? get addressCity;
  @override
  @JsonKey(name: 'addressPostalCode')
  String? get addressPostalCode;
  @override
  @JsonKey(name: 'addressCountry')
  String? get addressCountry;

  /// Create a copy of UpdateProfileRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileRequestModelImplCopyWith<_$UpdateProfileRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
