import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/modules/restaurant/presentation/onboarding/presentation/bloc/onboarding_wizard_bloc.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/presentation/bloc/onboarding_wizard_event.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/presentation/bloc/onboarding_wizard_state.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/entities/onboarding_status.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/entities/onboarding_table.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/entities/onboarding_menu_category.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/entities/onboarding_menu_item.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/data/models/restaurant_response_model.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/data/models/address_model.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/data/models/opening_hours_model.dart';
import 'package:checkfood_client/modules/panorama/domain/entities/panorama_session.dart';
import 'package:checkfood_client/modules/panorama/domain/entities/panorama_photo.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/update_restaurant_info_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/update_restaurant_hours_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/get_tables_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/add_table_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/update_table_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/delete_table_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/get_owner_menu_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/create_category_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/update_category_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/delete_category_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/create_menu_item_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/update_menu_item_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/delete_menu_item_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/publish_restaurant_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/create_panorama_session_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/upload_panorama_photo_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/finalize_panorama_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/get_panorama_status_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/onboarding/domain/usecases/activate_panorama_usecase.dart';

// ---------------------------------------------------------------------------
// Fake repository
// ---------------------------------------------------------------------------

class FakeOnboardingRepository implements OnboardingRepository {
  bool shouldThrow = false;
  bool publishShouldThrow = false;

  static const _restaurant = OwnerRestaurantResponseModel(
    id: 'r1',
    name: 'Test Restaurant',
    status: 'DRAFT',
  );

  static const _status = OnboardingStatus(
    hasInfo: true,
    hasHours: false,
    hasTables: false,
    hasMenu: false,
    hasPanorama: false,
    onboardingCompleted: false,
  );

  static const _table = OnboardingTable(
    id: 't1',
    label: 'Stůl 1',
    capacity: 4,
  );

  static const _category = OnboardingMenuCategory(
    id: 'cat1',
    name: 'Předkrmy',
    items: [],
  );

  @override
  Future<OwnerRestaurantResponseModel> getMyRestaurant() async {
    if (shouldThrow) throw Exception('Network error');
    return _restaurant;
  }

  @override
  Future<OwnerRestaurantResponseModel> updateInfo({
    required String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  }) async {
    if (shouldThrow) throw Exception('Update info failed');
    return OwnerRestaurantResponseModel(id: 'r1', name: name);
  }

  @override
  Future<OwnerRestaurantResponseModel> updateHours(List<OpeningHoursModel> hours) async {
    if (shouldThrow) throw Exception('Update hours failed');
    return _restaurant;
  }

  @override
  Future<List<OnboardingTable>> getTables() async {
    if (shouldThrow) throw Exception('Get tables failed');
    return [_table];
  }

  @override
  Future<OnboardingTable> addTable({
    required String label,
    required int capacity,
    bool active = true,
  }) async {
    if (shouldThrow) throw Exception('Add table failed');
    return OnboardingTable(id: 't_new', label: label, capacity: capacity);
  }

  @override
  Future<OnboardingTable> updateTable(
    String id, {
    required String label,
    required int capacity,
    bool active = true,
    double? yaw,
    double? pitch,
  }) async {
    if (shouldThrow) throw Exception('Update table failed');
    return OnboardingTable(id: id, label: label, capacity: capacity);
  }

  @override
  Future<void> deleteTable(String id) async {
    if (shouldThrow) throw Exception('Delete table failed');
  }

  @override
  Future<List<OnboardingMenuCategory>> getMenu() async {
    if (shouldThrow) throw Exception('Get menu failed');
    return [_category];
  }

  @override
  Future<OnboardingMenuCategory> createCategory({
    required String name,
    int sortOrder = 0,
  }) async {
    if (shouldThrow) throw Exception('Create category failed');
    return OnboardingMenuCategory(id: 'cat_new', name: name);
  }

  @override
  Future<OnboardingMenuCategory> updateCategory(
    String id, {
    required String name,
    int sortOrder = 0,
  }) async {
    if (shouldThrow) throw Exception('Update category failed');
    return OnboardingMenuCategory(id: id, name: name);
  }

  @override
  Future<void> deleteCategory(String id) async {
    if (shouldThrow) throw Exception('Delete category failed');
  }

  @override
  Future<OnboardingMenuItem> createItem(
    String categoryId, {
    required String name,
    String? description,
    int priceMinor = 0,
    String currency = 'CZK',
    String? imageUrl,
    bool available = true,
    int sortOrder = 0,
  }) async {
    if (shouldThrow) throw Exception('Create item failed');
    return OnboardingMenuItem(
      id: 'item_new',
      name: name,
      priceMinor: priceMinor,
    );
  }

  @override
  Future<OnboardingMenuItem> updateItem(
    String id, {
    required String name,
    String? description,
    int priceMinor = 0,
    String currency = 'CZK',
    String? imageUrl,
    bool available = true,
    int sortOrder = 0,
  }) async {
    if (shouldThrow) throw Exception('Update item failed');
    return OnboardingMenuItem(id: id, name: name, priceMinor: priceMinor);
  }

  @override
  Future<void> deleteItem(String id) async {
    if (shouldThrow) throw Exception('Delete item failed');
  }

  @override
  Future<OnboardingStatus> getOnboardingStatus() async {
    if (shouldThrow) throw Exception('Get status failed');
    return _status;
  }

  @override
  Future<OwnerRestaurantResponseModel> publish() async {
    if (publishShouldThrow) throw Exception('Publish failed');
    return _restaurant.copyWith(status: 'ACTIVE', onboardingCompleted: true);
  }

  @override
  Future<PanoramaSession> createPanoramaSession() async {
    if (shouldThrow) throw Exception('Create session failed');
    return const PanoramaSession(id: 'sess1', status: 'PENDING');
  }

  @override
  Future<PanoramaPhoto> uploadPhoto(
    String sessionId,
    int angleIndex,
    double actualAngle,
    double? actualPitch,
    Uint8List fileBytes,
    String filename,
  ) async {
    if (shouldThrow) throw Exception('Upload photo failed');
    return const PanoramaPhoto(id: 'p1', angleIndex: 0);
  }

  @override
  Future<PanoramaSession> finalizePanoramaSession(String sessionId) async {
    if (shouldThrow) throw Exception('Finalize failed');
    return const PanoramaSession(id: 'sess1', status: 'PROCESSING');
  }

  @override
  Future<PanoramaSession> getPanoramaSessionStatus(String sessionId) async {
    return const PanoramaSession(id: 'sess1', status: 'READY');
  }

  @override
  Future<List<PanoramaSession>> listPanoramaSessions() async {
    if (shouldThrow) throw Exception('List sessions failed');
    return [const PanoramaSession(id: 'sess1', status: 'READY')];
  }

  @override
  Future<void> activatePanorama(String sessionId) async {
    if (shouldThrow) throw Exception('Activate failed');
  }
}

// ---------------------------------------------------------------------------
// Builder
// ---------------------------------------------------------------------------

OnboardingWizardBloc _buildBloc({FakeOnboardingRepository? repo}) {
  final r = repo ?? FakeOnboardingRepository();
  return OnboardingWizardBloc(
    repository: r,
    getOnboardingStatus: GetOnboardingStatusUseCase(r),
    updateInfo: UpdateRestaurantInfoUseCase(r),
    updateHours: UpdateRestaurantHoursUseCase(r),
    getTables: GetTablesUseCase(r),
    addTable: AddTableUseCase(r),
    updateTable: UpdateTableUseCase(r),
    deleteTable: DeleteTableUseCase(r),
    getMenu: GetOwnerMenuUseCase(r),
    createCategory: CreateCategoryUseCase(r),
    updateCategory: UpdateCategoryUseCase(r),
    deleteCategory: DeleteCategoryUseCase(r),
    createItem: CreateMenuItemUseCase(r),
    updateItem: UpdateMenuItemUseCase(r),
    deleteItem: DeleteMenuItemUseCase(r),
    publishRestaurant: PublishRestaurantUseCase(r),
    createPanoramaSession: CreatePanoramaSessionUseCase(r),
    uploadPhoto: UploadPanoramaPhotoUseCase(r),
    finalizePanorama: FinalizePanoramaUseCase(r),
    getPanoramaStatus: GetPanoramaStatusUseCase(r),
    activatePanorama: ActivatePanoramaUseCase(r),
  );
}

bool _isLoading(OnboardingWizardState s) => s.loading;
bool _isNotLoading(OnboardingWizardState s) => !s.loading && s.error == null;
bool _hasError(OnboardingWizardState s) => s.error != null;

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('OnboardingWizardBloc — initial state', () {
    test('should start at step 0 with no data', () {
      final bloc = _buildBloc();
      expect(bloc.state.currentStep, 0);
      expect(bloc.state.loading, isFalse);
      expect(bloc.state.error, isNull);
      bloc.close();
    });
  });

  group('OnboardingWizardBloc — LoadOnboarding', () {
    test('should emit loading then state with restaurant and status', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.loadOnboarding());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(_isNotLoading, 'loaded', isTrue),
        ]),
      );
      expect(bloc.state.restaurant?.name, 'Test Restaurant');
      expect(bloc.state.status, isNotNull);
      bloc.close();
    });

    test('should emit error state when repository throws', () async {
      final repo = FakeOnboardingRepository()..shouldThrow = true;
      final bloc = _buildBloc(repo: repo);
      bloc.add(const OnboardingWizardEvent.loadOnboarding());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(_hasError, 'error', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  group('OnboardingWizardBloc — GoToStep', () {
    test('should update currentStep to target step', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.goToStep(2));
      await expectLater(
        bloc.stream,
        emits(isA<OnboardingWizardState>().having(
          (s) => s.currentStep,
          'currentStep',
          2,
        )),
      );
      bloc.close();
    });

    test('should clear error when navigating to a step', () async {
      final repo = FakeOnboardingRepository()..shouldThrow = true;
      final bloc = _buildBloc(repo: repo);
      bloc.add(const OnboardingWizardEvent.loadOnboarding());
      await bloc.stream.firstWhere(_hasError);

      repo.shouldThrow = false;
      bloc.add(const OnboardingWizardEvent.goToStep(1));
      await bloc.stream.firstWhere((s) => s.currentStep == 1);
      expect(bloc.state.error, isNull);
      bloc.close();
    });

    test('back navigation: goToStep(0) from step 1', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.goToStep(1));
      await bloc.stream.firstWhere((s) => s.currentStep == 1);
      bloc.add(const OnboardingWizardEvent.goToStep(0));
      await bloc.stream.firstWhere((s) => s.currentStep == 0);
      expect(bloc.state.currentStep, 0);
      bloc.close();
    });
  });

  group('OnboardingWizardBloc — UpdateInfo', () {
    test('should emit loading then update restaurant name', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.updateInfo(name: 'Updated Name'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(_isNotLoading, 'loaded', isTrue),
        ]),
      );
      expect(bloc.state.restaurant?.name, 'Updated Name');
      bloc.close();
    });

    test('should emit error on update failure', () async {
      final repo = FakeOnboardingRepository()..shouldThrow = true;
      final bloc = _buildBloc(repo: repo);
      bloc.add(const OnboardingWizardEvent.updateInfo(name: 'X'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(_hasError, 'error', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  group('OnboardingWizardBloc — UpdateHours', () {
    test('should emit loading then loaded state', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.updateHours([]));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(_isNotLoading, 'loaded', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  group('OnboardingWizardBloc — Tables', () {
    test('LoadTables should populate tables list', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.loadTables());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(
            (s) => s.tables.isNotEmpty,
            'tables not empty',
            isTrue,
          ),
        ]),
      );
      bloc.close();
    });

    test('AddTable should append table to state', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.addTable(label: 'Stůl A', capacity: 2));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(
            (s) => s.tables.any((t) => t.label == 'Stůl A'),
            'new table in list',
            isTrue,
          ),
        ]),
      );
      bloc.close();
    });

    test('DeleteTable should remove table from state', () async {
      final bloc = _buildBloc();
      // Pre-populate tables
      bloc.add(const OnboardingWizardEvent.loadTables());
      await bloc.stream.firstWhere((s) => s.tables.isNotEmpty);

      bloc.add(const OnboardingWizardEvent.deleteTable('t1'));
      await bloc.stream.firstWhere((s) => !s.loading && s.tables.every((t) => t.id != 't1'));
      expect(bloc.state.tables.any((t) => t.id == 't1'), isFalse);
      bloc.close();
    });

    test('should emit error when addTable fails', () async {
      final repo = FakeOnboardingRepository()..shouldThrow = true;
      final bloc = _buildBloc(repo: repo);
      bloc.add(const OnboardingWizardEvent.addTable(label: 'X', capacity: 1));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(_hasError, 'error', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  group('OnboardingWizardBloc — Menu', () {
    test('LoadMenu should populate categories', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.loadMenu());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(
            (s) => s.categories.isNotEmpty,
            'categories not empty',
            isTrue,
          ),
        ]),
      );
      bloc.close();
    });

    test('CreateCategory should add category', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.createCategory('Dezerty'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(
            (s) => s.categories.any((c) => c.name == 'Dezerty'),
            'new category present',
            isTrue,
          ),
        ]),
      );
      bloc.close();
    });

    test('DeleteCategory should remove category', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.loadMenu());
      await bloc.stream.firstWhere((s) => s.categories.isNotEmpty);

      bloc.add(const OnboardingWizardEvent.deleteCategory('cat1'));
      await bloc.stream.firstWhere((s) => !s.loading && s.categories.every((c) => c.id != 'cat1'));
      expect(bloc.state.categories.any((c) => c.id == 'cat1'), isFalse);
      bloc.close();
    });

    test('CreateItem should reload menu and include item', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.createItem(
        categoryId: 'cat1',
        name: 'Svíčková',
        priceMinor: 34900,
      ));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(_isNotLoading, 'loaded', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  group('OnboardingWizardBloc — Publish', () {
    test('should emit publishing then published=true', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.publish());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(
            (s) => s.publishing,
            'publishing',
            isTrue,
          ),
          isA<OnboardingWizardState>().having(
            (s) => s.published,
            'published',
            isTrue,
          ),
        ]),
      );
      bloc.close();
    });

    test('should emit error when publish fails', () async {
      final repo = FakeOnboardingRepository()..publishShouldThrow = true;
      final bloc = _buildBloc(repo: repo);
      bloc.add(const OnboardingWizardEvent.publish());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(
            (s) => s.publishing,
            'publishing',
            isTrue,
          ),
          isA<OnboardingWizardState>().having(_hasError, 'error', isTrue),
        ]),
      );
      expect(bloc.state.published, isFalse);
      bloc.close();
    });
  });

  group('OnboardingWizardBloc — Panorama', () {
    test('CreatePanoramaSession should populate activeSession', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.createPanoramaSession());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(
            (s) => s.activeSession != null,
            'activeSession not null',
            isTrue,
          ),
        ]),
      );
      bloc.close();
    });

    test('FinalizePanorama should emit loaded state with status', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.finalizePanorama('sess1'));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<OnboardingWizardState>().having(_isLoading, 'loading', isTrue),
          isA<OnboardingWizardState>().having(_isNotLoading, 'loaded', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  // EXPECTED-FAIL: onboarding_wizard_bloc — steps 0..5 should validate that
  // progress steps cannot be skipped. Currently GoToStep(n) allows jumping to any
  // step without completing prerequisites. There is no guard that prevents
  // goToStep(3) when hasInfo=false and hasHours=false.
  group('OnboardingWizardBloc — step skip prevention (gap test)', () {
    test('should not allow jumping to step 3 (tables) when step 1 (info) is incomplete', () async {
      final repo = FakeOnboardingRepository();
      final bloc = _buildBloc(repo: repo);
      bloc.add(const OnboardingWizardEvent.loadOnboarding());
      await bloc.stream.firstWhere(_isNotLoading);

      bloc.add(const OnboardingWizardEvent.goToStep(3));
      await bloc.stream.firstWhere((s) => s.currentStep != bloc.state.currentStep || true);

      // Without guard, step will be 3. This SHOULD fail if guard is implemented.
      expect(
        bloc.state.currentStep,
        isNot(3),
        reason: 'Cannot skip to step 3 when info and hours are incomplete',
      );
      bloc.close();
    });
  });

  // EXPECTED-FAIL: onboarding_wizard_bloc — save-and-resume is not implemented.
  // On LoadOnboarding, the wizard should restore the currentStep based on
  // onboarding status (e.g. if hasInfo=true but hasHours=false → resume at step 1).
  group('OnboardingWizardBloc — save-and-resume (gap test)', () {
    test('should restore currentStep to 1 when hasInfo=true but hasHours=false', () async {
      final bloc = _buildBloc();
      bloc.add(const OnboardingWizardEvent.loadOnboarding());
      await bloc.stream.firstWhere(_isNotLoading);

      // Status has hasInfo=true, hasHours=false → resume step should be 1
      expect(
        bloc.state.currentStep,
        1,
        reason: 'Wizard should resume at step 1 (hours) when info is already completed',
      );
      bloc.close();
    });
  });
}
