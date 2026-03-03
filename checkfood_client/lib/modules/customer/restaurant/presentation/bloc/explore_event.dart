import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/request/map_params_model.dart'; // ✅ Import nového modelu

part 'explore_event.freezed.dart';

@freezed
class ExploreEvent with _$ExploreEvent {
  /// Spuštění inicializace (získání polohy, načtení seznamu)
  const factory ExploreEvent.initializeRequested() = InitializeRequested;

  /// Uživatel udělil/zamítl oprávnění k poloze
  const factory ExploreEvent.permissionResultReceived({required bool granted}) =
      PermissionResultReceived;

  /// ✅ OPRAVENO: Mapa se pohnula (změna výřezu)
  /// Nyní používá MapParamsModel pro zapouzdření všech mapových parametrů.
  const factory ExploreEvent.mapBoundsChanged({
    required MapParamsModel params,
  }) = MapBoundsChanged;

  /// Scroll seznamu dolů -> Načíst další stránku restaurací
  const factory ExploreEvent.loadMoreRequested() = LoadMoreRequested;

  /// Pull-to-refresh -> Kompletní znovunačtení dat od aktuální polohy
  const factory ExploreEvent.refreshRequested() = RefreshRequested;
}
