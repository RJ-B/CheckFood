import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

// Importy UseCases
import '../../../domain/usecases/profile/get_user_profile_usecase.dart';
import '../../../domain/usecases/profile/update_profile_usecase.dart';
import '../../../domain/usecases/profile/change_password_usecase.dart';
import '../../../domain/usecases/profile/logout_device_usecase.dart';
import '../../../domain/usecases/profile/logout_all_devices_usecase.dart';
import '../../../domain/usecases/profile/get_active_devices_usecase.dart';

// ✅ Nutný import pro typ <Device>
import '../../../domain/entities/device.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetActiveDevicesUseCase _getActiveDevicesUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final LogoutDeviceUseCase _logoutDeviceUseCase;
  final LogoutAllDevicesUseCase _logoutAllDevicesUseCase;

  UserBloc({
    required GetUserProfileUseCase getUserProfileUseCase,
    required GetActiveDevicesUseCase getActiveDevicesUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
    required LogoutDeviceUseCase logoutDeviceUseCase,
    required LogoutAllDevicesUseCase logoutAllDevicesUseCase,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _getActiveDevicesUseCase = getActiveDevicesUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       _changePasswordUseCase = changePasswordUseCase,
       _logoutDeviceUseCase = logoutDeviceUseCase,
       _logoutAllDevicesUseCase = logoutAllDevicesUseCase,
       super(const UserState.initial()) {
    // Registrace handlerů
    on<ProfileRequested>(_onProfileRequested);
    on<DevicesRequested>(_onDevicesRequested);
    on<ProfileUpdated>(_onProfileUpdated);
    on<PasswordChangeRequested>(_onPasswordChangeRequested);
    on<AllDevicesLogoutRequested>(_onAllDevicesLogoutRequested);
    on<DeviceLoggedOut>(_onDeviceLoggedOut);

    // ✅ NOVÉ: Handler pro vyčištění dat
    on<ClearDataRequested>(_onClearDataRequested);
  }

  /// 1. Načtení profilu
  Future<void> _onProfileRequested(
    ProfileRequested event,
    Emitter<UserState> emit,
  ) async {
    // Kontrola, zda už máme načteno (abychom neblikali loadingem zbytečně)
    final isAlreadyLoaded = state.maybeMap(
      loaded: (_) => true,
      orElse: () => false,
    );

    if (!isAlreadyLoaded) {
      emit(const UserState.loading());
    }

    try {
      // 1. Stáhneme profil
      final profile = await _getUserProfileUseCase();

      // 2. Pokusíme se zachovat aktuální seznam zařízení, pokud existuje
      final List<Device> currentDevices = state.maybeWhen(
        loaded: (_, devices) => devices,
        orElse: () => <Device>[],
      );

      // 3. Emitujeme stav Loaded
      emit(UserState.loaded(profile: profile, devices: currentDevices));

      // 4. Automaticky po načtení profilu spustíme načtení zařízení
      // (Aby se seznam aktualizoval)
      add(const UserEvent.devicesRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// 2. Načtení aktivních zařízení
  Future<void> _onDevicesRequested(
    DevicesRequested event,
    Emitter<UserState> emit,
  ) async {
    // Potřebujeme aktuální stav Loaded, abychom měli kam přidat zařízení
    final currentState = state.mapOrNull(loaded: (s) => s);

    if (currentState == null) {
      // Nemáme profil -> nemůžeme aktualizovat jen zařízení
      return;
    }

    try {
      final devices = await _getActiveDevicesUseCase();

      // Emitujeme kopii stavu s novými zařízeními
      emit(currentState.copyWith(devices: devices));
    } catch (e) {
      // U zařízení selhání nevadí tolik, jen zalogujeme nebo zobrazíme chybu,
      // ale ideálně bychom neměli shodit celý profil do Failure stavu.
      // Pro teď necháme failure, ale v budoucnu to můžeš řešit přes 'copyWith(error: ...)'
      emit(UserState.failure("Nepodařilo se načíst zařízení: $e"));
    }
  }

  /// 3. Aktualizace profilu
  Future<void> _onProfileUpdated(
    ProfileUpdated event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      final updatedProfile = await _updateProfileUseCase(event.request);

      // Po aktualizaci resetujeme zařízení (prázdný seznam) a vyžádáme je znovu
      emit(UserState.loaded(profile: updatedProfile, devices: <Device>[]));
      add(const UserEvent.devicesRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// 4. Změna hesla
  Future<void> _onPasswordChangeRequested(
    PasswordChangeRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      await _changePasswordUseCase(event.request);
      emit(const UserState.passwordChangeSuccess());
      // Po úspěšné změně hesla znovu načteme profil (pro jistotu)
      add(const UserEvent.profileRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// 5. Odhlášení všech zařízení
  Future<void> _onAllDevicesLogoutRequested(
    AllDevicesLogoutRequested event,
    Emitter<UserState> emit,
  ) async {
    try {
      await _logoutAllDevicesUseCase();
      emit(const UserState.devicesLogoutSuccess());
      add(const UserEvent.devicesRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// 6. Odhlášení jednoho zařízení
  Future<void> _onDeviceLoggedOut(
    DeviceLoggedOut event,
    Emitter<UserState> emit,
  ) async {
    try {
      await _logoutDeviceUseCase(event.deviceId);
      add(const UserEvent.devicesRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// ✅ 7. NOVÉ: Vyčištění dat (Reset)
  Future<void> _onClearDataRequested(
    ClearDataRequested event,
    Emitter<UserState> emit,
  ) async {
    // Jednoduše vrátíme BLoC do výchozího stavu
    emit(const UserState.initial());
  }
}
