// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_menu_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OnboardingMenuCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<OnboardingMenuItem> get items => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingMenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingMenuCategoryCopyWith<OnboardingMenuCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingMenuCategoryCopyWith<$Res> {
  factory $OnboardingMenuCategoryCopyWith(
    OnboardingMenuCategory value,
    $Res Function(OnboardingMenuCategory) then,
  ) = _$OnboardingMenuCategoryCopyWithImpl<$Res, OnboardingMenuCategory>;
  @useResult
  $Res call({String id, String name, List<OnboardingMenuItem> items});
}

/// @nodoc
class _$OnboardingMenuCategoryCopyWithImpl<
  $Res,
  $Val extends OnboardingMenuCategory
>
    implements $OnboardingMenuCategoryCopyWith<$Res> {
  _$OnboardingMenuCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingMenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? items = null}) {
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
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<OnboardingMenuItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingMenuCategoryImplCopyWith<$Res>
    implements $OnboardingMenuCategoryCopyWith<$Res> {
  factory _$$OnboardingMenuCategoryImplCopyWith(
    _$OnboardingMenuCategoryImpl value,
    $Res Function(_$OnboardingMenuCategoryImpl) then,
  ) = __$$OnboardingMenuCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, List<OnboardingMenuItem> items});
}

/// @nodoc
class __$$OnboardingMenuCategoryImplCopyWithImpl<$Res>
    extends
        _$OnboardingMenuCategoryCopyWithImpl<$Res, _$OnboardingMenuCategoryImpl>
    implements _$$OnboardingMenuCategoryImplCopyWith<$Res> {
  __$$OnboardingMenuCategoryImplCopyWithImpl(
    _$OnboardingMenuCategoryImpl _value,
    $Res Function(_$OnboardingMenuCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingMenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? items = null}) {
    return _then(
      _$OnboardingMenuCategoryImpl(
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
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<OnboardingMenuItem>,
      ),
    );
  }
}

/// @nodoc

class _$OnboardingMenuCategoryImpl implements _OnboardingMenuCategory {
  const _$OnboardingMenuCategoryImpl({
    required this.id,
    required this.name,
    final List<OnboardingMenuItem> items = const [],
  }) : _items = items;

  @override
  final String id;
  @override
  final String name;
  final List<OnboardingMenuItem> _items;
  @override
  @JsonKey()
  List<OnboardingMenuItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'OnboardingMenuCategory(id: $id, name: $name, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingMenuCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of OnboardingMenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingMenuCategoryImplCopyWith<_$OnboardingMenuCategoryImpl>
  get copyWith =>
      __$$OnboardingMenuCategoryImplCopyWithImpl<_$OnboardingMenuCategoryImpl>(
        this,
        _$identity,
      );
}

abstract class _OnboardingMenuCategory implements OnboardingMenuCategory {
  const factory _OnboardingMenuCategory({
    required final String id,
    required final String name,
    final List<OnboardingMenuItem> items,
  }) = _$OnboardingMenuCategoryImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  List<OnboardingMenuItem> get items;

  /// Create a copy of OnboardingMenuCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingMenuCategoryImplCopyWith<_$OnboardingMenuCategoryImpl>
  get copyWith => throw _privateConstructorUsedError;
}
