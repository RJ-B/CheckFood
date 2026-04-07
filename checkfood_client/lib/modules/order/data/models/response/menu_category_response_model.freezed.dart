// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_category_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MenuCategoryResponseModel _$MenuCategoryResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _MenuCategoryResponseModel.fromJson(json);
}

/// @nodoc
mixin _$MenuCategoryResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  List<MenuItemResponseModel> get items => throw _privateConstructorUsedError;

  /// Serializes this MenuCategoryResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuCategoryResponseModelCopyWith<MenuCategoryResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuCategoryResponseModelCopyWith<$Res> {
  factory $MenuCategoryResponseModelCopyWith(
    MenuCategoryResponseModel value,
    $Res Function(MenuCategoryResponseModel) then,
  ) = _$MenuCategoryResponseModelCopyWithImpl<$Res, MenuCategoryResponseModel>;
  @useResult
  $Res call({String? id, String? name, List<MenuItemResponseModel> items});
}

/// @nodoc
class _$MenuCategoryResponseModelCopyWithImpl<
  $Res,
  $Val extends MenuCategoryResponseModel
>
    implements $MenuCategoryResponseModelCopyWith<$Res> {
  _$MenuCategoryResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? items = null,
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
            items:
                null == items
                    ? _value.items
                    : items // ignore: cast_nullable_to_non_nullable
                        as List<MenuItemResponseModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MenuCategoryResponseModelImplCopyWith<$Res>
    implements $MenuCategoryResponseModelCopyWith<$Res> {
  factory _$$MenuCategoryResponseModelImplCopyWith(
    _$MenuCategoryResponseModelImpl value,
    $Res Function(_$MenuCategoryResponseModelImpl) then,
  ) = __$$MenuCategoryResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name, List<MenuItemResponseModel> items});
}

/// @nodoc
class __$$MenuCategoryResponseModelImplCopyWithImpl<$Res>
    extends
        _$MenuCategoryResponseModelCopyWithImpl<
          $Res,
          _$MenuCategoryResponseModelImpl
        >
    implements _$$MenuCategoryResponseModelImplCopyWith<$Res> {
  __$$MenuCategoryResponseModelImplCopyWithImpl(
    _$MenuCategoryResponseModelImpl _value,
    $Res Function(_$MenuCategoryResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? items = null,
  }) {
    return _then(
      _$MenuCategoryResponseModelImpl(
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
        items:
            null == items
                ? _value._items
                : items // ignore: cast_nullable_to_non_nullable
                    as List<MenuItemResponseModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuCategoryResponseModelImpl extends _MenuCategoryResponseModel {
  const _$MenuCategoryResponseModelImpl({
    this.id,
    this.name,
    final List<MenuItemResponseModel> items = const [],
  }) : _items = items,
       super._();

  factory _$MenuCategoryResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuCategoryResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  final List<MenuItemResponseModel> _items;
  @override
  @JsonKey()
  List<MenuItemResponseModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'MenuCategoryResponseModel(id: $id, name: $name, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuCategoryResponseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of MenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuCategoryResponseModelImplCopyWith<_$MenuCategoryResponseModelImpl>
  get copyWith => __$$MenuCategoryResponseModelImplCopyWithImpl<
    _$MenuCategoryResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuCategoryResponseModelImplToJson(this);
  }
}

abstract class _MenuCategoryResponseModel extends MenuCategoryResponseModel {
  const factory _MenuCategoryResponseModel({
    final String? id,
    final String? name,
    final List<MenuItemResponseModel> items,
  }) = _$MenuCategoryResponseModelImpl;
  const _MenuCategoryResponseModel._() : super._();

  factory _MenuCategoryResponseModel.fromJson(Map<String, dynamic> json) =
      _$MenuCategoryResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  List<MenuItemResponseModel> get items;

  /// Create a copy of MenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuCategoryResponseModelImplCopyWith<_$MenuCategoryResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
