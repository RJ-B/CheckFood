import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/explore_data.dart';

part 'explore_state.freezed.dart';

@freezed
class ExploreState with _$ExploreState {
  const factory ExploreState.initial() = _Initial;
  const factory ExploreState.loading() = _Loading;

  const factory ExploreState.loaded({required ExploreData data}) = Loaded;

  const factory ExploreState.error({required String message}) = _Error;

  const factory ExploreState.permissionRequired() = _PermissionRequired;
}
