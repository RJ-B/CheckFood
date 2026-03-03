import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/explore_data.dart';

part 'explore_state.freezed.dart';

@freezed
class ExploreState with _$ExploreState {
  const factory ExploreState.initial() = _Initial;
  const factory ExploreState.loading() = _Loading;

  /// Data načtena
  const factory ExploreState.loaded({required ExploreData data}) = Loaded;

  /// Chyba
  const factory ExploreState.error({required String message}) = _Error;

  /// Vyžadováno oprávnění k poloze
  const factory ExploreState.permissionRequired() = _PermissionRequired;
}
