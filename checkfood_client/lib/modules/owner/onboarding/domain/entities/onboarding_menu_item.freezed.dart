// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OnboardingMenuItem {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get priceMinor => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingMenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingMenuItemCopyWith<OnboardingMenuItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingMenuItemCopyWith<$Res> {
  factory $OnboardingMenuItemCopyWith(
    OnboardingMenuItem value,
    $Res Function(OnboardingMenuItem) then,
  ) = _$OnboardingMenuItemCopyWithImpl<$Res, OnboardingMenuItem>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    int priceMinor,
    String currency,
    String? imageUrl,
    bool available,
  });
}

/// @nodoc
class _$OnboardingMenuItemCopyWithImpl<$Res, $Val extends OnboardingMenuItem>
    implements $OnboardingMenuItemCopyWith<$Res> {
  _$OnboardingMenuItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingMenuItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceMinor = null,
    Object? currency = null,
    Object? imageUrl = freezed,
    Object? available = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingMenuItemImplCopyWith<$Res>
    implements $OnboardingMenuItemCopyWith<$Res> {
  factory _$$OnboardingMenuItemImplCopyWith(
    _$OnboardingMenuItemImpl value,
    $Res Function(_$OnboardingMenuItemImpl) then,
  ) = __$$OnboardingMenuItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    int priceMinor,
    String currency,
    String? imageUrl,
    bool available,
  });
}

/// @nodoc
class __$$OnboardingMenuItemImplCopyWithImpl<$Res>
    extends _$OnboardingMenuItemCopyWithImpl<$Res, _$OnboardingMenuItemImpl>
    implements _$$OnboardingMenuItemImplCopyWith<$Res> {
  __$$OnboardingMenuItemImplCopyWithImpl(
    _$OnboardingMenuItemImpl _value,
    $Res Function(_$OnboardingMenuItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingMenuItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceMinor = null,
    Object? currency = null,
    Object? imageUrl = freezed,
    Object? available = null,
  }) {
    return _then(
      _$OnboardingMenuItemImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
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
      ),
    );
  }
}

/// @nodoc

class _$OnboardingMenuItemImpl implements _OnboardingMenuItem {
  const _$OnboardingMenuItemImpl({
    required this.id,
    required this.name,
    this.description,
    this.priceMinor = 0,
    this.currency = 'CZK',
    this.imageUrl,
    this.available = true,
  });

  @override
  final String id;
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
  String toString() {
    return 'OnboardingMenuItem(id: $id, name: $name, description: $description, priceMinor: $priceMinor, currency: $currency, imageUrl: $imageUrl, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingMenuItemImpl &&
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

  /// Create a copy of OnboardingMenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingMenuItemImplCopyWith<_$OnboardingMenuItemImpl> get copyWith =>
      __$$OnboardingMenuItemImplCopyWithImpl<_$OnboardingMenuItemImpl>(
        this,
        _$identity,
      );
}

abstract class _OnboardingMenuItem implements OnboardingMenuItem {
  const factory _OnboardingMenuItem({
    required final String id,
    required final String name,
    final String? description,
    final int priceMinor,
    final String currency,
    final String? imageUrl,
    final bool available,
  }) = _$OnboardingMenuItemImpl;

  @override
  String get id;
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

  /// Create a copy of OnboardingMenuItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingMenuItemImplCopyWith<_$OnboardingMenuItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
