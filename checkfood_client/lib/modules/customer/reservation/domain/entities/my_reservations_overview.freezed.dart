// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_reservations_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyReservationsOverview {
  List<Reservation> get upcoming => throw _privateConstructorUsedError;
  List<Reservation> get history => throw _privateConstructorUsedError;
  int get totalHistoryCount => throw _privateConstructorUsedError;

  /// Create a copy of MyReservationsOverview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyReservationsOverviewCopyWith<MyReservationsOverview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyReservationsOverviewCopyWith<$Res> {
  factory $MyReservationsOverviewCopyWith(
    MyReservationsOverview value,
    $Res Function(MyReservationsOverview) then,
  ) = _$MyReservationsOverviewCopyWithImpl<$Res, MyReservationsOverview>;
  @useResult
  $Res call({
    List<Reservation> upcoming,
    List<Reservation> history,
    int totalHistoryCount,
  });
}

/// @nodoc
class _$MyReservationsOverviewCopyWithImpl<
  $Res,
  $Val extends MyReservationsOverview
>
    implements $MyReservationsOverviewCopyWith<$Res> {
  _$MyReservationsOverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyReservationsOverview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? history = null,
    Object? totalHistoryCount = null,
  }) {
    return _then(
      _value.copyWith(
            upcoming:
                null == upcoming
                    ? _value.upcoming
                    : upcoming // ignore: cast_nullable_to_non_nullable
                        as List<Reservation>,
            history:
                null == history
                    ? _value.history
                    : history // ignore: cast_nullable_to_non_nullable
                        as List<Reservation>,
            totalHistoryCount:
                null == totalHistoryCount
                    ? _value.totalHistoryCount
                    : totalHistoryCount // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MyReservationsOverviewImplCopyWith<$Res>
    implements $MyReservationsOverviewCopyWith<$Res> {
  factory _$$MyReservationsOverviewImplCopyWith(
    _$MyReservationsOverviewImpl value,
    $Res Function(_$MyReservationsOverviewImpl) then,
  ) = __$$MyReservationsOverviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Reservation> upcoming,
    List<Reservation> history,
    int totalHistoryCount,
  });
}

/// @nodoc
class __$$MyReservationsOverviewImplCopyWithImpl<$Res>
    extends
        _$MyReservationsOverviewCopyWithImpl<$Res, _$MyReservationsOverviewImpl>
    implements _$$MyReservationsOverviewImplCopyWith<$Res> {
  __$$MyReservationsOverviewImplCopyWithImpl(
    _$MyReservationsOverviewImpl _value,
    $Res Function(_$MyReservationsOverviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsOverview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? history = null,
    Object? totalHistoryCount = null,
  }) {
    return _then(
      _$MyReservationsOverviewImpl(
        upcoming:
            null == upcoming
                ? _value._upcoming
                : upcoming // ignore: cast_nullable_to_non_nullable
                    as List<Reservation>,
        history:
            null == history
                ? _value._history
                : history // ignore: cast_nullable_to_non_nullable
                    as List<Reservation>,
        totalHistoryCount:
            null == totalHistoryCount
                ? _value.totalHistoryCount
                : totalHistoryCount // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$MyReservationsOverviewImpl implements _MyReservationsOverview {
  const _$MyReservationsOverviewImpl({
    required final List<Reservation> upcoming,
    required final List<Reservation> history,
    required this.totalHistoryCount,
  }) : _upcoming = upcoming,
       _history = history;

  final List<Reservation> _upcoming;
  @override
  List<Reservation> get upcoming {
    if (_upcoming is EqualUnmodifiableListView) return _upcoming;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcoming);
  }

  final List<Reservation> _history;
  @override
  List<Reservation> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  final int totalHistoryCount;

  @override
  String toString() {
    return 'MyReservationsOverview(upcoming: $upcoming, history: $history, totalHistoryCount: $totalHistoryCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyReservationsOverviewImpl &&
            const DeepCollectionEquality().equals(other._upcoming, _upcoming) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.totalHistoryCount, totalHistoryCount) ||
                other.totalHistoryCount == totalHistoryCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_upcoming),
    const DeepCollectionEquality().hash(_history),
    totalHistoryCount,
  );

  /// Create a copy of MyReservationsOverview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyReservationsOverviewImplCopyWith<_$MyReservationsOverviewImpl>
  get copyWith =>
      __$$MyReservationsOverviewImplCopyWithImpl<_$MyReservationsOverviewImpl>(
        this,
        _$identity,
      );
}

abstract class _MyReservationsOverview implements MyReservationsOverview {
  const factory _MyReservationsOverview({
    required final List<Reservation> upcoming,
    required final List<Reservation> history,
    required final int totalHistoryCount,
  }) = _$MyReservationsOverviewImpl;

  @override
  List<Reservation> get upcoming;
  @override
  List<Reservation> get history;
  @override
  int get totalHistoryCount;

  /// Create a copy of MyReservationsOverview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyReservationsOverviewImplCopyWith<_$MyReservationsOverviewImpl>
  get copyWith => throw _privateConstructorUsedError;
}
