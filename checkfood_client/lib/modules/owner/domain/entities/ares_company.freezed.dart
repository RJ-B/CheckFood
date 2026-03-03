// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ares_company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AresCompany {
  String get ico => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  String? get restaurantId => throw _privateConstructorUsedError;
  List<String> get statutoryPersons => throw _privateConstructorUsedError;

  /// Create a copy of AresCompany
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AresCompanyCopyWith<AresCompany> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AresCompanyCopyWith<$Res> {
  factory $AresCompanyCopyWith(
    AresCompany value,
    $Res Function(AresCompany) then,
  ) = _$AresCompanyCopyWithImpl<$Res, AresCompany>;
  @useResult
  $Res call({
    String ico,
    String companyName,
    String? restaurantId,
    List<String> statutoryPersons,
  });
}

/// @nodoc
class _$AresCompanyCopyWithImpl<$Res, $Val extends AresCompany>
    implements $AresCompanyCopyWith<$Res> {
  _$AresCompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AresCompany
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ico = null,
    Object? companyName = null,
    Object? restaurantId = freezed,
    Object? statutoryPersons = null,
  }) {
    return _then(
      _value.copyWith(
            ico:
                null == ico
                    ? _value.ico
                    : ico // ignore: cast_nullable_to_non_nullable
                        as String,
            companyName:
                null == companyName
                    ? _value.companyName
                    : companyName // ignore: cast_nullable_to_non_nullable
                        as String,
            restaurantId:
                freezed == restaurantId
                    ? _value.restaurantId
                    : restaurantId // ignore: cast_nullable_to_non_nullable
                        as String?,
            statutoryPersons:
                null == statutoryPersons
                    ? _value.statutoryPersons
                    : statutoryPersons // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AresCompanyImplCopyWith<$Res>
    implements $AresCompanyCopyWith<$Res> {
  factory _$$AresCompanyImplCopyWith(
    _$AresCompanyImpl value,
    $Res Function(_$AresCompanyImpl) then,
  ) = __$$AresCompanyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String ico,
    String companyName,
    String? restaurantId,
    List<String> statutoryPersons,
  });
}

/// @nodoc
class __$$AresCompanyImplCopyWithImpl<$Res>
    extends _$AresCompanyCopyWithImpl<$Res, _$AresCompanyImpl>
    implements _$$AresCompanyImplCopyWith<$Res> {
  __$$AresCompanyImplCopyWithImpl(
    _$AresCompanyImpl _value,
    $Res Function(_$AresCompanyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AresCompany
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ico = null,
    Object? companyName = null,
    Object? restaurantId = freezed,
    Object? statutoryPersons = null,
  }) {
    return _then(
      _$AresCompanyImpl(
        ico:
            null == ico
                ? _value.ico
                : ico // ignore: cast_nullable_to_non_nullable
                    as String,
        companyName:
            null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                    as String,
        restaurantId:
            freezed == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String?,
        statutoryPersons:
            null == statutoryPersons
                ? _value._statutoryPersons
                : statutoryPersons // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$AresCompanyImpl implements _AresCompany {
  const _$AresCompanyImpl({
    required this.ico,
    required this.companyName,
    this.restaurantId,
    final List<String> statutoryPersons = const [],
  }) : _statutoryPersons = statutoryPersons;

  @override
  final String ico;
  @override
  final String companyName;
  @override
  final String? restaurantId;
  final List<String> _statutoryPersons;
  @override
  @JsonKey()
  List<String> get statutoryPersons {
    if (_statutoryPersons is EqualUnmodifiableListView)
      return _statutoryPersons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statutoryPersons);
  }

  @override
  String toString() {
    return 'AresCompany(ico: $ico, companyName: $companyName, restaurantId: $restaurantId, statutoryPersons: $statutoryPersons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AresCompanyImpl &&
            (identical(other.ico, ico) || other.ico == ico) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            const DeepCollectionEquality().equals(
              other._statutoryPersons,
              _statutoryPersons,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    ico,
    companyName,
    restaurantId,
    const DeepCollectionEquality().hash(_statutoryPersons),
  );

  /// Create a copy of AresCompany
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AresCompanyImplCopyWith<_$AresCompanyImpl> get copyWith =>
      __$$AresCompanyImplCopyWithImpl<_$AresCompanyImpl>(this, _$identity);
}

abstract class _AresCompany implements AresCompany {
  const factory _AresCompany({
    required final String ico,
    required final String companyName,
    final String? restaurantId,
    final List<String> statutoryPersons,
  }) = _$AresCompanyImpl;

  @override
  String get ico;
  @override
  String get companyName;
  @override
  String? get restaurantId;
  @override
  List<String> get statutoryPersons;

  /// Create a copy of AresCompany
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AresCompanyImplCopyWith<_$AresCompanyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
