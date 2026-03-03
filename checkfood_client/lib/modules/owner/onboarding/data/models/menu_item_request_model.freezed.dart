// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MenuItemRequestModel _$MenuItemRequestModelFromJson(Map<String, dynamic> json) {
  return _MenuItemRequestModel.fromJson(json);
}

/// @nodoc
mixin _$MenuItemRequestModel {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get priceMinor => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this MenuItemRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemRequestModelCopyWith<MenuItemRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemRequestModelCopyWith<$Res> {
  factory $MenuItemRequestModelCopyWith(
    MenuItemRequestModel value,
    $Res Function(MenuItemRequestModel) then,
  ) = _$MenuItemRequestModelCopyWithImpl<$Res, MenuItemRequestModel>;
  @useResult
  $Res call({
    String name,
    String? description,
    int priceMinor,
    String currency,
    String? imageUrl,
    bool available,
    int sortOrder,
  });
}

/// @nodoc
class _$MenuItemRequestModelCopyWithImpl<
  $Res,
  $Val extends MenuItemRequestModel
>
    implements $MenuItemRequestModelCopyWith<$Res> {
  _$MenuItemRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? priceMinor = null,
    Object? currency = null,
    Object? imageUrl = freezed,
    Object? available = null,
    Object? sortOrder = null,
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
            sortOrder:
                null == sortOrder
                    ? _value.sortOrder
                    : sortOrder // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MenuItemRequestModelImplCopyWith<$Res>
    implements $MenuItemRequestModelCopyWith<$Res> {
  factory _$$MenuItemRequestModelImplCopyWith(
    _$MenuItemRequestModelImpl value,
    $Res Function(_$MenuItemRequestModelImpl) then,
  ) = __$$MenuItemRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String? description,
    int priceMinor,
    String currency,
    String? imageUrl,
    bool available,
    int sortOrder,
  });
}

/// @nodoc
class __$$MenuItemRequestModelImplCopyWithImpl<$Res>
    extends _$MenuItemRequestModelCopyWithImpl<$Res, _$MenuItemRequestModelImpl>
    implements _$$MenuItemRequestModelImplCopyWith<$Res> {
  __$$MenuItemRequestModelImplCopyWithImpl(
    _$MenuItemRequestModelImpl _value,
    $Res Function(_$MenuItemRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? priceMinor = null,
    Object? currency = null,
    Object? imageUrl = freezed,
    Object? available = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$MenuItemRequestModelImpl(
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
        sortOrder:
            null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuItemRequestModelImpl implements _MenuItemRequestModel {
  const _$MenuItemRequestModelImpl({
    required this.name,
    this.description,
    this.priceMinor = 0,
    this.currency = 'CZK',
    this.imageUrl,
    this.available = true,
    this.sortOrder = 0,
  });

  factory _$MenuItemRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemRequestModelImplFromJson(json);

  @override
  final String name;
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
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'MenuItemRequestModel(name: $name, description: $description, priceMinor: $priceMinor, currency: $currency, imageUrl: $imageUrl, available: $available, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemRequestModelImpl &&
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
                other.available == available) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    description,
    priceMinor,
    currency,
    imageUrl,
    available,
    sortOrder,
  );

  /// Create a copy of MenuItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemRequestModelImplCopyWith<_$MenuItemRequestModelImpl>
  get copyWith =>
      __$$MenuItemRequestModelImplCopyWithImpl<_$MenuItemRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemRequestModelImplToJson(this);
  }
}

abstract class _MenuItemRequestModel implements MenuItemRequestModel {
  const factory _MenuItemRequestModel({
    required final String name,
    final String? description,
    final int priceMinor,
    final String currency,
    final String? imageUrl,
    final bool available,
    final int sortOrder,
  }) = _$MenuItemRequestModelImpl;

  factory _MenuItemRequestModel.fromJson(Map<String, dynamic> json) =
      _$MenuItemRequestModelImpl.fromJson;

  @override
  String get name;
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
  @override
  int get sortOrder;

  /// Create a copy of MenuItemRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemRequestModelImplCopyWith<_$MenuItemRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
