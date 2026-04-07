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

MenuItemResponseModel _$MenuItemResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _MenuItemResponseModel.fromJson(json);
}

/// @nodoc
mixin _$MenuItemResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get priceMinor => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;

  /// Serializes this MenuItemResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemResponseModelCopyWith<MenuItemResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemResponseModelCopyWith<$Res> {
  factory $MenuItemResponseModelCopyWith(
    MenuItemResponseModel value,
    $Res Function(MenuItemResponseModel) then,
  ) = _$MenuItemResponseModelCopyWithImpl<$Res, MenuItemResponseModel>;
  @useResult
  $Res call({
    String? id,
    String? name,
    String? description,
    int? priceMinor,
    String? currency,
    String? imageUrl,
    bool available,
  });
}

/// @nodoc
class _$MenuItemResponseModelCopyWithImpl<
  $Res,
  $Val extends MenuItemResponseModel
>
    implements $MenuItemResponseModelCopyWith<$Res> {
  _$MenuItemResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? priceMinor = freezed,
    Object? currency = freezed,
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
                freezed == priceMinor
                    ? _value.priceMinor
                    : priceMinor // ignore: cast_nullable_to_non_nullable
                        as int?,
            currency:
                freezed == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String?,
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
abstract class _$$MenuItemResponseModelImplCopyWith<$Res>
    implements $MenuItemResponseModelCopyWith<$Res> {
  factory _$$MenuItemResponseModelImplCopyWith(
    _$MenuItemResponseModelImpl value,
    $Res Function(_$MenuItemResponseModelImpl) then,
  ) = __$$MenuItemResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? name,
    String? description,
    int? priceMinor,
    String? currency,
    String? imageUrl,
    bool available,
  });
}

/// @nodoc
class __$$MenuItemResponseModelImplCopyWithImpl<$Res>
    extends
        _$MenuItemResponseModelCopyWithImpl<$Res, _$MenuItemResponseModelImpl>
    implements _$$MenuItemResponseModelImplCopyWith<$Res> {
  __$$MenuItemResponseModelImplCopyWithImpl(
    _$MenuItemResponseModelImpl _value,
    $Res Function(_$MenuItemResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? priceMinor = freezed,
    Object? currency = freezed,
    Object? imageUrl = freezed,
    Object? available = null,
  }) {
    return _then(
      _$MenuItemResponseModelImpl(
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
            freezed == priceMinor
                ? _value.priceMinor
                : priceMinor // ignore: cast_nullable_to_non_nullable
                    as int?,
        currency:
            freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String?,
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
class _$MenuItemResponseModelImpl extends _MenuItemResponseModel {
  const _$MenuItemResponseModelImpl({
    this.id,
    this.name,
    this.description,
    this.priceMinor,
    this.currency,
    this.imageUrl,
    this.available = true,
  }) : super._();

  factory _$MenuItemResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final int? priceMinor;
  @override
  final String? currency;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool available;

  @override
  String toString() {
    return 'MenuItemResponseModel(id: $id, name: $name, description: $description, priceMinor: $priceMinor, currency: $currency, imageUrl: $imageUrl, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemResponseModelImpl &&
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

  /// Create a copy of MenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemResponseModelImplCopyWith<_$MenuItemResponseModelImpl>
  get copyWith =>
      __$$MenuItemResponseModelImplCopyWithImpl<_$MenuItemResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemResponseModelImplToJson(this);
  }
}

abstract class _MenuItemResponseModel extends MenuItemResponseModel {
  const factory _MenuItemResponseModel({
    final String? id,
    final String? name,
    final String? description,
    final int? priceMinor,
    final String? currency,
    final String? imageUrl,
    final bool available,
  }) = _$MenuItemResponseModelImpl;
  const _MenuItemResponseModel._() : super._();

  factory _MenuItemResponseModel.fromJson(Map<String, dynamic> json) =
      _$MenuItemResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  int? get priceMinor;
  @override
  String? get currency;
  @override
  String? get imageUrl;
  @override
  bool get available;

  /// Create a copy of MenuItemResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemResponseModelImplCopyWith<_$MenuItemResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
