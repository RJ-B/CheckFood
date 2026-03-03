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

OwnerMenuCategoryResponseModel _$OwnerMenuCategoryResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _OwnerMenuCategoryResponseModel.fromJson(json);
}

/// @nodoc
mixin _$OwnerMenuCategoryResponseModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  List<OwnerMenuItemResponseModel> get items =>
      throw _privateConstructorUsedError;

  /// Serializes this OwnerMenuCategoryResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OwnerMenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OwnerMenuCategoryResponseModelCopyWith<OwnerMenuCategoryResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerMenuCategoryResponseModelCopyWith<$Res> {
  factory $OwnerMenuCategoryResponseModelCopyWith(
    OwnerMenuCategoryResponseModel value,
    $Res Function(OwnerMenuCategoryResponseModel) then,
  ) =
      _$OwnerMenuCategoryResponseModelCopyWithImpl<
        $Res,
        OwnerMenuCategoryResponseModel
      >;
  @useResult
  $Res call({String? id, String? name, List<OwnerMenuItemResponseModel> items});
}

/// @nodoc
class _$OwnerMenuCategoryResponseModelCopyWithImpl<
  $Res,
  $Val extends OwnerMenuCategoryResponseModel
>
    implements $OwnerMenuCategoryResponseModelCopyWith<$Res> {
  _$OwnerMenuCategoryResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OwnerMenuCategoryResponseModel
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
                        as List<OwnerMenuItemResponseModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OwnerMenuCategoryResponseModelImplCopyWith<$Res>
    implements $OwnerMenuCategoryResponseModelCopyWith<$Res> {
  factory _$$OwnerMenuCategoryResponseModelImplCopyWith(
    _$OwnerMenuCategoryResponseModelImpl value,
    $Res Function(_$OwnerMenuCategoryResponseModelImpl) then,
  ) = __$$OwnerMenuCategoryResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name, List<OwnerMenuItemResponseModel> items});
}

/// @nodoc
class __$$OwnerMenuCategoryResponseModelImplCopyWithImpl<$Res>
    extends
        _$OwnerMenuCategoryResponseModelCopyWithImpl<
          $Res,
          _$OwnerMenuCategoryResponseModelImpl
        >
    implements _$$OwnerMenuCategoryResponseModelImplCopyWith<$Res> {
  __$$OwnerMenuCategoryResponseModelImplCopyWithImpl(
    _$OwnerMenuCategoryResponseModelImpl _value,
    $Res Function(_$OwnerMenuCategoryResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OwnerMenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? items = null,
  }) {
    return _then(
      _$OwnerMenuCategoryResponseModelImpl(
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
                    as List<OwnerMenuItemResponseModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OwnerMenuCategoryResponseModelImpl
    extends _OwnerMenuCategoryResponseModel {
  const _$OwnerMenuCategoryResponseModelImpl({
    this.id,
    this.name,
    final List<OwnerMenuItemResponseModel> items = const [],
  }) : _items = items,
       super._();

  factory _$OwnerMenuCategoryResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$OwnerMenuCategoryResponseModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  final List<OwnerMenuItemResponseModel> _items;
  @override
  @JsonKey()
  List<OwnerMenuItemResponseModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'OwnerMenuCategoryResponseModel(id: $id, name: $name, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerMenuCategoryResponseModelImpl &&
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

  /// Create a copy of OwnerMenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerMenuCategoryResponseModelImplCopyWith<
    _$OwnerMenuCategoryResponseModelImpl
  >
  get copyWith => __$$OwnerMenuCategoryResponseModelImplCopyWithImpl<
    _$OwnerMenuCategoryResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OwnerMenuCategoryResponseModelImplToJson(this);
  }
}

abstract class _OwnerMenuCategoryResponseModel
    extends OwnerMenuCategoryResponseModel {
  const factory _OwnerMenuCategoryResponseModel({
    final String? id,
    final String? name,
    final List<OwnerMenuItemResponseModel> items,
  }) = _$OwnerMenuCategoryResponseModelImpl;
  const _OwnerMenuCategoryResponseModel._() : super._();

  factory _OwnerMenuCategoryResponseModel.fromJson(Map<String, dynamic> json) =
      _$OwnerMenuCategoryResponseModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  List<OwnerMenuItemResponseModel> get items;

  /// Create a copy of OwnerMenuCategoryResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OwnerMenuCategoryResponseModelImplCopyWith<
    _$OwnerMenuCategoryResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
