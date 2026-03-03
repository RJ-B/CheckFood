// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ares_lookup_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AresLookupResponseModel _$AresLookupResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AresLookupResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AresLookupResponseModel {
  String get ico => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  String? get restaurantId => throw _privateConstructorUsedError;
  bool get requiresIdentityVerification => throw _privateConstructorUsedError;
  List<String> get statutoryPersons => throw _privateConstructorUsedError;

  /// Serializes this AresLookupResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AresLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AresLookupResponseModelCopyWith<AresLookupResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AresLookupResponseModelCopyWith<$Res> {
  factory $AresLookupResponseModelCopyWith(
    AresLookupResponseModel value,
    $Res Function(AresLookupResponseModel) then,
  ) = _$AresLookupResponseModelCopyWithImpl<$Res, AresLookupResponseModel>;
  @useResult
  $Res call({
    String ico,
    String companyName,
    String? restaurantId,
    bool requiresIdentityVerification,
    List<String> statutoryPersons,
  });
}

/// @nodoc
class _$AresLookupResponseModelCopyWithImpl<
  $Res,
  $Val extends AresLookupResponseModel
>
    implements $AresLookupResponseModelCopyWith<$Res> {
  _$AresLookupResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AresLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ico = null,
    Object? companyName = null,
    Object? restaurantId = freezed,
    Object? requiresIdentityVerification = null,
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
            requiresIdentityVerification:
                null == requiresIdentityVerification
                    ? _value.requiresIdentityVerification
                    : requiresIdentityVerification // ignore: cast_nullable_to_non_nullable
                        as bool,
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
abstract class _$$AresLookupResponseModelImplCopyWith<$Res>
    implements $AresLookupResponseModelCopyWith<$Res> {
  factory _$$AresLookupResponseModelImplCopyWith(
    _$AresLookupResponseModelImpl value,
    $Res Function(_$AresLookupResponseModelImpl) then,
  ) = __$$AresLookupResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String ico,
    String companyName,
    String? restaurantId,
    bool requiresIdentityVerification,
    List<String> statutoryPersons,
  });
}

/// @nodoc
class __$$AresLookupResponseModelImplCopyWithImpl<$Res>
    extends
        _$AresLookupResponseModelCopyWithImpl<
          $Res,
          _$AresLookupResponseModelImpl
        >
    implements _$$AresLookupResponseModelImplCopyWith<$Res> {
  __$$AresLookupResponseModelImplCopyWithImpl(
    _$AresLookupResponseModelImpl _value,
    $Res Function(_$AresLookupResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AresLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ico = null,
    Object? companyName = null,
    Object? restaurantId = freezed,
    Object? requiresIdentityVerification = null,
    Object? statutoryPersons = null,
  }) {
    return _then(
      _$AresLookupResponseModelImpl(
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
        requiresIdentityVerification:
            null == requiresIdentityVerification
                ? _value.requiresIdentityVerification
                : requiresIdentityVerification // ignore: cast_nullable_to_non_nullable
                    as bool,
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
@JsonSerializable()
class _$AresLookupResponseModelImpl extends _AresLookupResponseModel {
  const _$AresLookupResponseModelImpl({
    required this.ico,
    required this.companyName,
    this.restaurantId,
    this.requiresIdentityVerification = true,
    final List<String> statutoryPersons = const [],
  }) : _statutoryPersons = statutoryPersons,
       super._();

  factory _$AresLookupResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AresLookupResponseModelImplFromJson(json);

  @override
  final String ico;
  @override
  final String companyName;
  @override
  final String? restaurantId;
  @override
  @JsonKey()
  final bool requiresIdentityVerification;
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
    return 'AresLookupResponseModel(ico: $ico, companyName: $companyName, restaurantId: $restaurantId, requiresIdentityVerification: $requiresIdentityVerification, statutoryPersons: $statutoryPersons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AresLookupResponseModelImpl &&
            (identical(other.ico, ico) || other.ico == ico) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(
                  other.requiresIdentityVerification,
                  requiresIdentityVerification,
                ) ||
                other.requiresIdentityVerification ==
                    requiresIdentityVerification) &&
            const DeepCollectionEquality().equals(
              other._statutoryPersons,
              _statutoryPersons,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ico,
    companyName,
    restaurantId,
    requiresIdentityVerification,
    const DeepCollectionEquality().hash(_statutoryPersons),
  );

  /// Create a copy of AresLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AresLookupResponseModelImplCopyWith<_$AresLookupResponseModelImpl>
  get copyWith => __$$AresLookupResponseModelImplCopyWithImpl<
    _$AresLookupResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AresLookupResponseModelImplToJson(this);
  }
}

abstract class _AresLookupResponseModel extends AresLookupResponseModel {
  const factory _AresLookupResponseModel({
    required final String ico,
    required final String companyName,
    final String? restaurantId,
    final bool requiresIdentityVerification,
    final List<String> statutoryPersons,
  }) = _$AresLookupResponseModelImpl;
  const _AresLookupResponseModel._() : super._();

  factory _AresLookupResponseModel.fromJson(Map<String, dynamic> json) =
      _$AresLookupResponseModelImpl.fromJson;

  @override
  String get ico;
  @override
  String get companyName;
  @override
  String? get restaurantId;
  @override
  bool get requiresIdentityVerification;
  @override
  List<String> get statutoryPersons;

  /// Create a copy of AresLookupResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AresLookupResponseModelImplCopyWith<_$AresLookupResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
