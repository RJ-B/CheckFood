import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/onboarding_status.dart';
import '../../domain/usecases/get_onboarding_status_usecase.dart';
import '../../domain/usecases/update_restaurant_info_usecase.dart';
import '../../domain/usecases/update_restaurant_hours_usecase.dart';
import '../../domain/usecases/get_tables_usecase.dart';
import '../../domain/usecases/add_table_usecase.dart';
import '../../domain/usecases/update_table_usecase.dart';
import '../../domain/usecases/delete_table_usecase.dart';
import '../../domain/usecases/get_owner_menu_usecase.dart';
import '../../domain/usecases/create_category_usecase.dart';
import '../../domain/usecases/update_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import '../../domain/usecases/create_menu_item_usecase.dart';
import '../../domain/usecases/update_menu_item_usecase.dart';
import '../../domain/usecases/delete_menu_item_usecase.dart';
import '../../domain/usecases/publish_restaurant_usecase.dart';
import '../../domain/usecases/create_panorama_session_usecase.dart';
import '../../domain/usecases/upload_panorama_photo_usecase.dart';
import '../../domain/usecases/finalize_panorama_usecase.dart';
import '../../domain/usecases/get_panorama_status_usecase.dart';
import '../../domain/usecases/activate_panorama_usecase.dart';
import '../../domain/repositories/onboarding_repository.dart';
import 'onboarding_wizard_event.dart';
import 'onboarding_wizard_state.dart';

/// BLoC řídící průvodce onboardingem restaurace napříč všemi kroky: načítání
/// stavu, aktualizaci informací a otevíracích dob, správu stolů a menu,
/// vytváření a polling panorama sessions a zveřejnění restaurace.
class OnboardingWizardBloc extends Bloc<OnboardingWizardEvent, OnboardingWizardState> {
  final OnboardingRepository _repository;
  final GetOnboardingStatusUseCase _getOnboardingStatus;
  final UpdateRestaurantInfoUseCase _updateInfo;
  final UpdateRestaurantHoursUseCase _updateHours;
  final GetTablesUseCase _getTables;
  final AddTableUseCase _addTable;
  final UpdateTableUseCase _updateTable;
  final DeleteTableUseCase _deleteTable;
  final GetOwnerMenuUseCase _getMenu;
  final CreateCategoryUseCase _createCategory;
  final UpdateCategoryUseCase _updateCategory;
  final DeleteCategoryUseCase _deleteCategory;
  final CreateMenuItemUseCase _createItem;
  final UpdateMenuItemUseCase _updateItem;
  final DeleteMenuItemUseCase _deleteItem;
  final PublishRestaurantUseCase _publish;
  final CreatePanoramaSessionUseCase _createPanoramaSession;
  final UploadPanoramaPhotoUseCase _uploadPhoto;
  final FinalizePanoramaUseCase _finalizePanorama;
  final GetPanoramaStatusUseCase _getPanoramaStatus;
  final ActivatePanoramaUseCase _activatePanorama;

  OnboardingWizardBloc({
    required OnboardingRepository repository,
    required GetOnboardingStatusUseCase getOnboardingStatus,
    required UpdateRestaurantInfoUseCase updateInfo,
    required UpdateRestaurantHoursUseCase updateHours,
    required GetTablesUseCase getTables,
    required AddTableUseCase addTable,
    required UpdateTableUseCase updateTable,
    required DeleteTableUseCase deleteTable,
    required GetOwnerMenuUseCase getMenu,
    required CreateCategoryUseCase createCategory,
    required UpdateCategoryUseCase updateCategory,
    required DeleteCategoryUseCase deleteCategory,
    required CreateMenuItemUseCase createItem,
    required UpdateMenuItemUseCase updateItem,
    required DeleteMenuItemUseCase deleteItem,
    required PublishRestaurantUseCase publishRestaurant,
    required CreatePanoramaSessionUseCase createPanoramaSession,
    required UploadPanoramaPhotoUseCase uploadPhoto,
    required FinalizePanoramaUseCase finalizePanorama,
    required GetPanoramaStatusUseCase getPanoramaStatus,
    required ActivatePanoramaUseCase activatePanorama,
  })  : _repository = repository,
        _getOnboardingStatus = getOnboardingStatus,
        _updateInfo = updateInfo,
        _updateHours = updateHours,
        _getTables = getTables,
        _addTable = addTable,
        _updateTable = updateTable,
        _deleteTable = deleteTable,
        _getMenu = getMenu,
        _createCategory = createCategory,
        _updateCategory = updateCategory,
        _deleteCategory = deleteCategory,
        _createItem = createItem,
        _updateItem = updateItem,
        _deleteItem = deleteItem,
        _publish = publishRestaurant,
        _createPanoramaSession = createPanoramaSession,
        _uploadPhoto = uploadPhoto,
        _finalizePanorama = finalizePanorama,
        _getPanoramaStatus = getPanoramaStatus,
        _activatePanorama = activatePanorama,
        super(const OnboardingWizardState()) {
    on<LoadOnboarding>(_onLoadOnboarding);
    on<GoToStep>(_onGoToStep);
    on<UpdateInfo>(_onUpdateInfo);
    on<UpdateHours>(_onUpdateHours);
    on<LoadTables>(_onLoadTables);
    on<AddTable>(_onAddTable);
    on<UpdateTable>(_onUpdateTable);
    on<DeleteTable>(_onDeleteTable);
    on<LoadMenu>(_onLoadMenu);
    on<CreateCategory>(_onCreateCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<CreateItem>(_onCreateItem);
    on<UpdateItem>(_onUpdateItem);
    on<DeleteItem>(_onDeleteItem);
    on<CreatePanoramaSession>(_onCreatePanoramaSession);
    on<UploadPhoto>(_onUploadPhoto);
    on<FinalizePanorama>(_onFinalizePanorama);
    on<ActivatePanorama>(_onActivatePanorama);
    on<LoadPanoramaSessions>(_onLoadPanoramaSessions);
    on<PollPanoramaStatus>(_onPollPanoramaStatus);
    on<Publish>(_onPublish);
  }

  Future<void> _onLoadOnboarding(LoadOnboarding event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final status = await _getOnboardingStatus();
      final restaurant = await _repository.getMyRestaurant();
      // Save-and-resume: jump the wizard to the first incomplete step
      // rather than always starting at 0. User who has info+hours but
      // bailed out mid-tables will be taken back to step 2, not step 0.
      final int resumeStep = _maxUnlockedStep(status);
      emit(state.copyWith(
        loading: false,
        status: status,
        restaurant: restaurant,
        currentStep: resumeStep,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void _onGoToStep(GoToStep event, Emitter<OnboardingWizardState> emit) {
    // Backwards navigation is always allowed — the user can revisit any
    // previously completed step. Forward navigation is capped at
    // (highestUnlockedStep); this prevents jumping ahead to step 3 (tables)
    // while step 1 (info) is still empty, which would crash the underlying
    // form reading null fields.
    final int target = event.step;
    if (target <= state.currentStep) {
      emit(state.copyWith(currentStep: target, error: null));
      return;
    }
    final int maxAllowed = _maxUnlockedStep(state.status);
    final int clamped = target > maxAllowed ? maxAllowed : target;
    emit(state.copyWith(currentStep: clamped, error: null));
  }

  /// Highest step the user may jump to given the current onboarding status.
  ///
  /// Steps:
  ///   0 = info
  ///   1 = hours (unlocked once info is saved)
  ///   2 = tables (unlocked once hours saved)
  ///   3 = menu (unlocked once tables saved)
  ///   4 = panorama (unlocked once menu saved)
  ///   5 = summary / publish (unlocked once panorama ready)
  int _maxUnlockedStep(OnboardingStatus? status) {
    if (status == null) return 0;
    if (!status.hasInfo) return 0;
    if (!status.hasHours) return 1;
    if (!status.hasTables) return 2;
    if (!status.hasMenu) return 3;
    if (!status.hasPanorama) return 4;
    return 5;
  }

  Future<void> _onUpdateInfo(UpdateInfo event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final restaurant = await _updateInfo(
        name: event.name,
        description: event.description,
        phone: event.phone,
        email: event.email,
        address: event.address,
        cuisineType: event.cuisineType,
      );
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, restaurant: restaurant, status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateHours(UpdateHours event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final restaurant = await _updateHours(event.hours);
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, restaurant: restaurant, status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadTables(LoadTables event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final tables = await _getTables();
      emit(state.copyWith(loading: false, tables: tables));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onAddTable(AddTable event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final table = await _addTable(label: event.label, capacity: event.capacity);
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, tables: [...state.tables, table], status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateTable(UpdateTable event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final updated = await _updateTable(event.id, label: event.label, capacity: event.capacity);
      final tables = state.tables.map((t) => t.id == event.id ? updated : t).toList();
      emit(state.copyWith(loading: false, tables: tables));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteTable(DeleteTable event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await _deleteTable(event.id);
      final tables = state.tables.where((t) => t.id != event.id).toList();
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, tables: tables, status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadMenu(LoadMenu event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final categories = await _getMenu();
      emit(state.copyWith(loading: false, categories: categories));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onCreateCategory(CreateCategory event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final category = await _createCategory(name: event.name);
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, categories: [...state.categories, category], status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateCategory(UpdateCategory event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final updated = await _updateCategory(event.id, name: event.name);
      final categories = state.categories.map((c) => c.id == event.id ? updated : c).toList();
      emit(state.copyWith(loading: false, categories: categories));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteCategory(DeleteCategory event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await _deleteCategory(event.id);
      final categories = state.categories.where((c) => c.id != event.id).toList();
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, categories: categories, status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onCreateItem(CreateItem event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await _createItem(
        event.categoryId,
        name: event.name,
        description: event.description,
        priceMinor: event.priceMinor,
      );
      final categories = await _getMenu();
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, categories: categories, status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateItem(UpdateItem event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await _updateItem(
        event.id,
        name: event.name,
        description: event.description,
        priceMinor: event.priceMinor,
      );
      final categories = await _getMenu();
      emit(state.copyWith(loading: false, categories: categories));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteItem(DeleteItem event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await _deleteItem(event.id);
      final categories = await _getMenu();
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, categories: categories, status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onCreatePanoramaSession(CreatePanoramaSession event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final session = await _createPanoramaSession();
      emit(state.copyWith(loading: false, activeSession: session, sessions: [...state.sessions, session]));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onUploadPhoto(UploadPhoto event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await _uploadPhoto(
        sessionId: event.sessionId,
        angleIndex: event.angleIndex,
        actualAngle: event.actualAngle,
        actualPitch: event.actualPitch,
        fileBytes: event.fileBytes,
        filename: event.filename,
      );
      final session = await _getPanoramaStatus(event.sessionId);
      emit(state.copyWith(loading: false, activeSession: session));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onFinalizePanorama(FinalizePanorama event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final session = await _finalizePanorama(event.sessionId);
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, activeSession: session, status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onActivatePanorama(ActivatePanorama event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await _activatePanorama(event.sessionId);
      final status = await _getOnboardingStatus();
      emit(state.copyWith(loading: false, status: status));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onLoadPanoramaSessions(LoadPanoramaSessions event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final sessions = await _repository.listPanoramaSessions();
      emit(state.copyWith(loading: false, sessions: sessions));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _onPollPanoramaStatus(PollPanoramaStatus event, Emitter<OnboardingWizardState> emit) async {
    try {
      final session = await _getPanoramaStatus(event.sessionId);
      final updatedSessions = state.sessions.map((s) => s.id == session.id ? session : s).toList();
      emit(state.copyWith(activeSession: session, sessions: updatedSessions));

      if (session.status == 'PROCESSING') {
        await Future.delayed(const Duration(seconds: 3));
        if (!isClosed) {
          add(OnboardingWizardEvent.pollPanoramaStatus(event.sessionId));
        }
      }
    } catch (_) {
      await Future.delayed(const Duration(seconds: 5));
      if (!isClosed) {
        add(OnboardingWizardEvent.pollPanoramaStatus(event.sessionId));
      }
    }
  }

  Future<void> _onPublish(Publish event, Emitter<OnboardingWizardState> emit) async {
    emit(state.copyWith(publishing: true, error: null));
    try {
      await _publish();
      emit(state.copyWith(publishing: false, published: true));
    } catch (e) {
      emit(state.copyWith(publishing: false, error: e.toString()));
    }
  }
}
