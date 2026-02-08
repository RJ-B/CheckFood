import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

// Importy UseCases
import '../../../domain/usecases/profile/get_user_profile_usecase.dart';
import '../../../domain/usecases/profile/update_profile_usecase.dart';
import '../../../domain/usecases/profile/change_password_usecase.dart';
import '../../../domain/usecases/profile/logout_device_usecase.dart';
import '../../../domain/usecases/profile/logout_all_devices_usecase.dart'; // Ten nový

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final LogoutDeviceUseCase _logoutDeviceUseCase;
  final LogoutAllDevicesUseCase _logoutAllDevicesUseCase;

  UserBloc({
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
    required LogoutDeviceUseCase logoutDeviceUseCase,
    required LogoutAllDevicesUseCase logoutAllDevicesUseCase,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       _changePasswordUseCase = changePasswordUseCase,
       _logoutDeviceUseCase = logoutDeviceUseCase,
       _logoutAllDevicesUseCase = logoutAllDevicesUseCase,
       super(const UserState.initial()) {
    on<UserEvent>(_onEvent);
  }

  Future<void> _onEvent(UserEvent event, Emitter<UserState> emit) async {
    await event.map(
      profileRequested: (e) => _onProfileRequested(e, emit),
      profileUpdated: (e) => _onProfileUpdated(e, emit),
      passwordChangeRequested: (e) => _onPasswordChangeRequested(e, emit),
      allDevicesLogoutRequested: (e) => _onAllDevicesLogoutRequested(e, emit),
      deviceLoggedOut: (e) => _onDeviceLoggedOut(e, emit),
    );
  }

  Future<void> _onProfileRequested(
    ProfileRequested event,
    Emitter<UserState> emit,
  ) async {
    // Pokud už data máme, mohli bychom jen přepsat stav, ale pro refresh dáme loading
    emit(const UserState.loading());
    try {
      final profile = await _getUserProfileUseCase();
      emit(UserState.loaded(profile));
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _onProfileUpdated(
    ProfileUpdated event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      // UseCase vrací rovnou aktualizovaný profil
      final updatedProfile = await _updateProfileUseCase(event.request);
      emit(UserState.loaded(updatedProfile));
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _onPasswordChangeRequested(
    PasswordChangeRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      await _changePasswordUseCase(event.request);

      // Emitujeme úspěch. UI by mělo zareagovat (např. Toast/Snackbar)
      // a následně asi odhlásit uživatele nebo jen vyčistit formulář.
      emit(const UserState.passwordChangeSuccess());

      // Po změně hesla je dobré znovu načíst profil (pro jistotu, např. kvůli timestampu změny)
      add(const UserEvent.profileRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _onAllDevicesLogoutRequested(
    AllDevicesLogoutRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      await _logoutAllDevicesUseCase();
      emit(const UserState.devicesLogoutSuccess());
      // Refresh profilu (počet aktivních zařízení se změnil)
      add(const UserEvent.profileRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  Future<void> _onDeviceLoggedOut(
    DeviceLoggedOut event,
    Emitter<UserState> emit,
  ) async {
    // Zde nedáváme globální loading, aby neproblikla celá obrazovka,
    // pokud to UI řeší lokálně u položky seznamu.
    try {
      await _logoutDeviceUseCase(event.deviceId);
      // Po úspěšném smazání refreshneme profil (seznam zařízení je součástí profilu)
      add(const UserEvent.profileRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }
}
