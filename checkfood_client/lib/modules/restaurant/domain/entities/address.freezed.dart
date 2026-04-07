// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Address {
  String get street => throw _privateConstructorUsedError;
  String? get streetNumber => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get googlePlaceId => throw _privateConstructorUsedError;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call({
    String street,
    String? streetNumber,
    String city,
    String? postalCode,
    String country,
    double? latitude,
    double? longitude,
    String? googlePlaceId,
  });
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? streetNumber = freezed,
    Object? city = null,
    Object? postalCode = freezed,
    Object? country = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? googlePlaceId = freezed,
  }) {
    return _then(
      _value.copyWith(
            street:
                null == street
                    ? _value.street
                    : street // ignore: cast_nullable_to_non_nullable
                        as String,
            streetNumber:
                freezed == streetNumber
                    ? _value.streetNumber
                    : streetNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            city:
                null == city
                    ? _value.city
                    : city // ignore: cast_nullable_to_non_nullable
                        as String,
            postalCode:
                freezed == postalCode
                    ? _value.postalCode
                    : postalCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            country:
                null == country
                    ? _value.country
                    : country // ignore: cast_nullable_to_non_nullable
                        as String,
            latitude:
                freezed == latitude
                    ? _value.latitude
                    : latitude // ignore: cast_nullable_to_non_nullable
                        as double?,
            longitude:
                freezed == longitude
                    ? _value.longitude
                    : longitude // ignore: cast_nullable_to_non_nullable
                        as double?,
            googlePlaceId:
                freezed == googlePlaceId
                    ? _value.googlePlaceId
                    : googlePlaceId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressImplCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$AddressImplCopyWith(
    _$AddressImpl value,
    $Res Function(_$AddressImpl) then,
  ) = __$$AddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String street,
    String? streetNumber,
    String city,
    String? postalCode,
    String country,
    double? latitude,
    double? longitude,
    String? googlePlaceId,
  });
}

/// @nodoc
class __$$AddressImplCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$AddressImpl>
    implements _$$AddressImplCopyWith<$Res> {
  __$$AddressImplCopyWithImpl(
    _$AddressImpl _value,
    $Res Function(_$AddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? street = null,
    Object? streetNumber = freezed,
    Object? city = null,
    Object? postalCode = freezed,
    Object? country = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? googlePlaceId = freezed,
  }) {
    return _then(
      _$AddressImpl(
        street:
            null == street
                ? _value.street
                : street // ignore: cast_nullable_to_non_nullable
                    as String,
        streetNumber:
            freezed == streetNumber
                ? _value.streetNumber
                : streetNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        city:
            null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                    as String,
        postalCode:
            freezed == postalCode
                ? _value.postalCode
                : postalCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        country:
            null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                    as String,
        latitude:
            freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                    as double?,
        longitude:
            freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                    as double?,
        googlePlaceId:
            freezed == googlePlaceId
                ? _value.googlePlaceId
                : googlePlaceId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$AddressImpl extends _Address {
  const _$AddressImpl({
    required this.street,
    this.streetNumber,
    required this.city,
    this.postalCode,
    required this.country,
    this.latitude,
    this.longitude,
    this.googlePlaceId,
  }) : super._();

  @override
  final String street;
  @override
  final String? streetNumber;
  @override
  final String city;
  @override
  final String? postalCode;
  @override
  final String country;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? googlePlaceId;

  @override
  String toString() {
    return 'Address(street: $street, streetNumber: $streetNumber, city: $city, postalCode: $postalCode, country: $country, latitude: $latitude, longitude: $longitude, googlePlaceId: $googlePlaceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressImpl &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.streetNumber, streetNumber) ||
                other.streetNumber == streetNumber) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.googlePlaceId, googlePlaceId) ||
                other.googlePlaceId == googlePlaceId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    street,
    streetNumber,
    city,
    postalCode,
    country,
    latitude,
    longitude,
    googlePlaceId,
  );

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      __$$AddressImplCopyWithImpl<_$AddressImpl>(this, _$identity);
}

abstract class _Address extends Address {
  const factory _Address({
    required final String street,
    final String? streetNumber,
    required final String city,
    final String? postalCode,
    required final String country,
    final double? latitude,
    final double? longitude,
    final String? googlePlaceId,
  }) = _$AddressImpl;
  const _Address._() : super._();

  @override
  String get street;
  @override
  String? get streetNumber;
  @override
  String get city;
  @override
  String? get postalCode;
  @override
  String get country;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get googlePlaceId;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressImplCopyWith<_$AddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
