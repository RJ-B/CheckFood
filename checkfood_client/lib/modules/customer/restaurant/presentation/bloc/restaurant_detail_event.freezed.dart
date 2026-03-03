// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_detail_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RestaurantDetailEvent {
  String get restaurantId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadDetailRequested value) loadRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadDetailRequested value)? loadRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadDetailRequested value)? loadRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantDetailEventCopyWith<RestaurantDetailEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantDetailEventCopyWith<$Res> {
  factory $RestaurantDetailEventCopyWith(
    RestaurantDetailEvent value,
    $Res Function(RestaurantDetailEvent) then,
  ) = _$RestaurantDetailEventCopyWithImpl<$Res, RestaurantDetailEvent>;
  @useResult
  $Res call({String restaurantId});
}

/// @nodoc
class _$RestaurantDetailEventCopyWithImpl<
  $Res,
  $Val extends RestaurantDetailEvent
>
    implements $RestaurantDetailEventCopyWith<$Res> {
  _$RestaurantDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? restaurantId = null}) {
    return _then(
      _value.copyWith(
            restaurantId:
                null == restaurantId
                    ? _value.restaurantId
                    : restaurantId // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoadDetailRequestedImplCopyWith<$Res>
    implements $RestaurantDetailEventCopyWith<$Res> {
  factory _$$LoadDetailRequestedImplCopyWith(
    _$LoadDetailRequestedImpl value,
    $Res Function(_$LoadDetailRequestedImpl) then,
  ) = __$$LoadDetailRequestedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String restaurantId});
}

/// @nodoc
class __$$LoadDetailRequestedImplCopyWithImpl<$Res>
    extends _$RestaurantDetailEventCopyWithImpl<$Res, _$LoadDetailRequestedImpl>
    implements _$$LoadDetailRequestedImplCopyWith<$Res> {
  __$$LoadDetailRequestedImplCopyWithImpl(
    _$LoadDetailRequestedImpl _value,
    $Res Function(_$LoadDetailRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? restaurantId = null}) {
    return _then(
      _$LoadDetailRequestedImpl(
        restaurantId:
            null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadDetailRequestedImpl implements LoadDetailRequested {
  const _$LoadDetailRequestedImpl({required this.restaurantId});

  @override
  final String restaurantId;

  @override
  String toString() {
    return 'RestaurantDetailEvent.loadRequested(restaurantId: $restaurantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadDetailRequestedImpl &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, restaurantId);

  /// Create a copy of RestaurantDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadDetailRequestedImplCopyWith<_$LoadDetailRequestedImpl> get copyWith =>
      __$$LoadDetailRequestedImplCopyWithImpl<_$LoadDetailRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String restaurantId) loadRequested,
  }) {
    return loadRequested(restaurantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String restaurantId)? loadRequested,
  }) {
    return loadRequested?.call(restaurantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String restaurantId)? loadRequested,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(restaurantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadDetailRequested value) loadRequested,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadDetailRequested value)? loadRequested,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadDetailRequested value)? loadRequested,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class LoadDetailRequested implements RestaurantDetailEvent {
  const factory LoadDetailRequested({required final String restaurantId}) =
      _$LoadDetailRequestedImpl;

  @override
  String get restaurantId;

  /// Create a copy of RestaurantDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadDetailRequestedImplCopyWith<_$LoadDetailRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
