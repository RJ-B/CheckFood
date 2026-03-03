// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OwnerMenuItemResponseModel _$OwnerMenuItemResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _OwnerMenuItemResponseModel.fromJson(json);
}

/// @nodoc
mixin _$OwnerMenuItemResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get priceMinor => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;

  /// Serializes this OwnerMenuItemResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OwnerMenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OwnerMenuItemResponseModelCopyWith<OwnerMenuItemResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerMenuItemResponseModelCopyWith<$Res> {
  factory $OwnerMenuItemResponseModelCopyWith(
    OwnerMenuItemResponseModel value,
    $Res Function(OwnerMenuItemResponseModel) then,
  ) =
      _$OwnerMenuItemResponseModelCopyWithImpl<
        $Res,
        OwnerMenuItemResponseModel
      >;
  @useResult
  $Res call({
    String? id,
    String? name,
    String? description,
    int priceMinor,
    String currency,
    String? imageUrl,
    bool available,
  });
}

/// @nodoc
class _$OwnerMenuItemResponseModelCopyWithImpl<
  $Res,
  $Val extends OwnerMenuItemResponseModel
>
    implements $OwnerMenuItemResponseModelCopyWith<$Res> {
  _$OwnerMenuItemResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OwnerMenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? priceMinor = null,
    Object? currency = null,
    Object? imageUrl = freezed,
    Object? available = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            priceMinor:
                null == priceMinor
                    ? _value.priceMinor
                    : priceMinor // ignore: cast_nullable_to_non_nullable
                        as int,
            currency:
                null == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String,
            imageUrl:
                freezed == imageUrl
                    ? _value.imageUrl
                    : imageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            available:
                null == available
                    ? _value.available
                    : available // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OwnerMenuItemResponseModelImplCopyWith<$Res>
    implements $OwnerMenuItemResponseModelCopyWith<$Res> {
  factory _$$OwnerMenuItemResponseModelImplCopyWith(
    _$OwnerMenuItemResponseModelImpl value,
    $Res Function(_$OwnerMenuItemResponseModelImpl) then,
  ) = __$$OwnerMenuItemResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? name,
    String? description,
    int priceMinor,
    String currency,
    String? imageUrl,
    bool available,
  });
}

/// @nodoc
class __$$OwnerMenuItemResponseModelImplCopyWithImpl<$Res>
    extends
        _$OwnerMenuItemResponseModelCopyWithImpl<
          $Res,
          _$OwnerMenuItemResponseModelImpl
        >
    implements _$$OwnerMenuItemResponseModelImplCopyWith<$Res> {
  __$$OwnerMenuItemResponseModelImplCopyWithImpl(
    _$OwnerMenuItemResponseModelImpl _value,
    $Res Function(_$OwnerMenuItemResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerMenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? priceMinor = null,
    Object? currency = null,
    Object? imageUrl = freezed,
    Object? available = null,
  }) {
    return _then(
      _$OwnerMenuItemResponseModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        priceMinor:
            null == priceMinor
                ? _value.priceMinor
                : priceMinor // ignore: cast_nullable_to_non_nullable
                    as int,
        currency:
            null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String,
        imageUrl:
            freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        available:
            null == available
                ? _value.available
                : available // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OwnerMenuItemResponseModelImpl extends _OwnerMenuItemResponseModel {
  const _$OwnerMenuItemResponseModelImpl({
    this.id,
    this.name,
    this.description,
    this.priceMinor = 0,
    this.currency = 'CZK',
    this.imageUrl,
    this.available = true,
  }) : super._();

  factory _$OwnerMenuItemResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$OwnerMenuItemResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  @JsonKey()
  final int priceMinor;
  @override
  @JsonKey()
  final String currency;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool available;

  @override
  String toString() {
    return 'OwnerMenuItemResponseModel(id: $id, name: $name, description: $description, priceMinor: $priceMinor, currency: $currency, imageUrl: $imageUrl, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerMenuItemResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceMinor, priceMinor) ||
                other.priceMinor == priceMinor) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.available, available) ||
                other.available == available));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    priceMinor,
    currency,
    imageUrl,
    available,
  );

  /// Create a copy of OwnerMenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerMenuItemResponseModelImplCopyWith<_$OwnerMenuItemResponseModelImpl>
  get copyWith => __$$OwnerMenuItemResponseModelImplCopyWithImpl<
    _$OwnerMenuItemResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OwnerMenuItemResponseModelImplToJson(this);
  }
}

abstract class _OwnerMenuItemResponseModel extends OwnerMenuItemResponseModel {
  const factory _OwnerMenuItemResponseModel({
    final String? id,
    final String? name,
    final String? description,
    final int priceMinor,
    final String currency,
    final String? imageUrl,
    final bool available,
  }) = _$OwnerMenuItemResponseModelImpl;
  const _OwnerMenuItemResponseModel._() : super._();

  factory _OwnerMenuItemResponseModel.fromJson(Map<String, dynamic> json) =
      _$OwnerMenuItemResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  int get priceMinor;
  @override
  String get currency;
  @override
  String? get imageUrl;
  @override
  bool get available;

  /// Create a copy of OwnerMenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OwnerMenuItemResponseModelImplCopyWith<_$OwnerMenuItemResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
