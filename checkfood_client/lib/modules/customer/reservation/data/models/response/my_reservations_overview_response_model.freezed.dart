// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_reservations_overview_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MyReservationsOverviewResponseModel
_$MyReservationsOverviewResponseModelFromJson(Map<String, dynamic> json) {
  return _MyReservationsOverviewResponseModel.fromJson(json);
}

/// @nodoc
mixin _$MyReservationsOverviewResponseModel {
  List<ReservationResponseModel> get upcoming =>
      throw _privateConstructorUsedError;
  List<ReservationResponseModel> get history =>
      throw _privateConstructorUsedError;
  int get totalHistoryCount => throw _privateConstructorUsedError;

  /// Serializes this MyReservationsOverviewResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MyReservationsOverviewResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyReservationsOverviewResponseModelCopyWith<
    MyReservationsOverviewResponseModel
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyReservationsOverviewResponseModelCopyWith<$Res> {
  factory $MyReservationsOverviewResponseModelCopyWith(
    MyReservationsOverviewResponseModel value,
    $Res Function(MyReservationsOverviewResponseModel) then,
  ) =
      _$MyReservationsOverviewResponseModelCopyWithImpl<
        $Res,
        MyReservationsOverviewResponseModel
      >;
  @useResult
  $Res call({
    List<ReservationResponseModel> upcoming,
    List<ReservationResponseModel> history,
    int totalHistoryCount,
  });
}

/// @nodoc
class _$MyReservationsOverviewResponseModelCopyWithImpl<
  $Res,
  $Val extends MyReservationsOverviewResponseModel
>
    implements $MyReservationsOverviewResponseModelCopyWith<$Res> {
  _$MyReservationsOverviewResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyReservationsOverviewResponseModel
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
                        as List<ReservationResponseModel>,
            history:
                null == history
                    ? _value.history
                    : history // ignore: cast_nullable_to_non_nullable
                        as List<ReservationResponseModel>,
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
abstract class _$$MyReservationsOverviewResponseModelImplCopyWith<$Res>
    implements $MyReservationsOverviewResponseModelCopyWith<$Res> {
  factory _$$MyReservationsOverviewResponseModelImplCopyWith(
    _$MyReservationsOverviewResponseModelImpl value,
    $Res Function(_$MyReservationsOverviewResponseModelImpl) then,
  ) = __$$MyReservationsOverviewResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ReservationResponseModel> upcoming,
    List<ReservationResponseModel> history,
    int totalHistoryCount,
  });
}

/// @nodoc
class __$$MyReservationsOverviewResponseModelImplCopyWithImpl<$Res>
    extends
        _$MyReservationsOverviewResponseModelCopyWithImpl<
          $Res,
          _$MyReservationsOverviewResponseModelImpl
        >
    implements _$$MyReservationsOverviewResponseModelImplCopyWith<$Res> {
  __$$MyReservationsOverviewResponseModelImplCopyWithImpl(
    _$MyReservationsOverviewResponseModelImpl _value,
    $Res Function(_$MyReservationsOverviewResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyReservationsOverviewResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? history = null,
    Object? totalHistoryCount = null,
  }) {
    return _then(
      _$MyReservationsOverviewResponseModelImpl(
        upcoming:
            null == upcoming
                ? _value._upcoming
                : upcoming // ignore: cast_nullable_to_non_nullable
                    as List<ReservationResponseModel>,
        history:
            null == history
                ? _value._history
                : history // ignore: cast_nullable_to_non_nullable
                    as List<ReservationResponseModel>,
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
@JsonSerializable()
class _$MyReservationsOverviewResponseModelImpl
    extends _MyReservationsOverviewResponseModel {
  const _$MyReservationsOverviewResponseModelImpl({
    final List<ReservationResponseModel> upcoming = const [],
    final List<ReservationResponseModel> history = const [],
    this.totalHistoryCount = 0,
  }) : _upcoming = upcoming,
       _history = history,
       super._();

  factory _$MyReservationsOverviewResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MyReservationsOverviewResponseModelImplFromJson(json);

  final List<ReservationResponseModel> _upcoming;
  @override
  @JsonKey()
  List<ReservationResponseModel> get upcoming {
    if (_upcoming is EqualUnmodifiableListView) return _upcoming;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcoming);
  }

  final List<ReservationResponseModel> _history;
  @override
  @JsonKey()
  List<ReservationResponseModel> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final int totalHistoryCount;

  @override
  String toString() {
    return 'MyReservationsOverviewResponseModel(upcoming: $upcoming, history: $history, totalHistoryCount: $totalHistoryCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyReservationsOverviewResponseModelImpl &&
            const DeepCollectionEquality().equals(other._upcoming, _upcoming) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.totalHistoryCount, totalHistoryCount) ||
                other.totalHistoryCount == totalHistoryCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_upcoming),
    const DeepCollectionEquality().hash(_history),
    totalHistoryCount,
  );

  /// Create a copy of MyReservationsOverviewResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyReservationsOverviewResponseModelImplCopyWith<
    _$MyReservationsOverviewResponseModelImpl
  >
  get copyWith => __$$MyReservationsOverviewResponseModelImplCopyWithImpl<
    _$MyReservationsOverviewResponseModelImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyReservationsOverviewResponseModelImplToJson(this);
  }
}

abstract class _MyReservationsOverviewResponseModel
    extends MyReservationsOverviewResponseModel {
  const factory _MyReservationsOverviewResponseModel({
    final List<ReservationResponseModel> upcoming,
    final List<ReservationResponseModel> history,
    final int totalHistoryCount,
  }) = _$MyReservationsOverviewResponseModelImpl;
  const _MyReservationsOverviewResponseModel._() : super._();

  factory _MyReservationsOverviewResponseModel.fromJson(
    Map<String, dynamic> json,
  ) = _$MyReservationsOverviewResponseModelImpl.fromJson;

  @override
  List<ReservationResponseModel> get upcoming;
  @override
  List<ReservationResponseModel> get history;
  @override
  int get totalHistoryCount;

  /// Create a copy of MyReservationsOverviewResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyReservationsOverviewResponseModelImplCopyWith<
    _$MyReservationsOverviewResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
