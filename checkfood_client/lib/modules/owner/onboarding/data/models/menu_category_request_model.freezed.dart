// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_category_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MenuCategoryRequestModel _$MenuCategoryRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _MenuCategoryRequestModel.fromJson(json);
}

/// @nodoc
mixin _$MenuCategoryRequestModel {
  String get name => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this MenuCategoryRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuCategoryRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuCategoryRequestModelCopyWith<MenuCategoryRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuCategoryRequestModelCopyWith<$Res> {
  factory $MenuCategoryRequestModelCopyWith(
    MenuCategoryRequestModel value,
    $Res Function(MenuCategoryRequestModel) then,
  ) = _$MenuCategoryRequestModelCopyWithImpl<$Res, MenuCategoryRequestModel>;
  @useResult
  $Res call({String name, int sortOrder});
}

/// @nodoc
class _$MenuCategoryRequestModelCopyWithImpl<
  $Res,
  $Val extends MenuCategoryRequestModel
>
    implements $MenuCategoryRequestModelCopyWith<$Res> {
  _$MenuCategoryRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuCategoryRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? sortOrder = null}) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
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
abstract class _$$MenuCategoryRequestModelImplCopyWith<$Res>
    implements $MenuCategoryRequestModelCopyWith<$Res> {
  factory _$$MenuCategoryRequestModelImplCopyWith(
    _$MenuCategoryRequestModelImpl value,
    $Res Function(_$MenuCategoryRequestModelImpl) then,
  ) = __$$MenuCategoryRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int sortOrder});
}

/// @nodoc
class __$$MenuCategoryRequestModelImplCopyWithImpl<$Res>
    extends
        _$MenuCategoryRequestModelCopyWithImpl<
          $Res,
          _$MenuCategoryRequestModelImpl
        >
    implements _$$MenuCategoryRequestModelImplCopyWith<$Res> {
  __$$MenuCategoryRequestModelImplCopyWithImpl(
    _$MenuCategoryRequestModelImpl _value,
    $Res Function(_$MenuCategoryRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuCategoryRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? sortOrder = null}) {
    return _then(
      _$MenuCategoryRequestModelImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
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
class _$MenuCategoryRequestModelImpl implements _MenuCategoryRequestModel {
  const _$MenuCategoryRequestModelImpl({
    required this.name,
    this.sortOrder = 0,
  });

  factory _$MenuCategoryRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuCategoryRequestModelImplFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'MenuCategoryRequestModel(name: $name, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuCategoryRequestModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, sortOrder);

  /// Create a copy of MenuCategoryRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuCategoryRequestModelImplCopyWith<_$MenuCategoryRequestModelImpl>
  get copyWith => __$$MenuCategoryRequestModelImplCopyWithImpl<
    _$MenuCategoryRequestModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuCategoryRequestModelImplToJson(this);
  }
}

abstract class _MenuCategoryRequestModel implements MenuCategoryRequestModel {
  const factory _MenuCategoryRequestModel({
    required final String name,
    final int sortOrder,
  }) = _$MenuCategoryRequestModelImpl;

  factory _MenuCategoryRequestModel.fromJson(Map<String, dynamic> json) =
      _$MenuCategoryRequestModelImpl.fromJson;

  @override
  String get name;
  @override
  int get sortOrder;

  /// Create a copy of MenuCategoryRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuCategoryRequestModelImplCopyWith<_$MenuCategoryRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
