import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../../domain/usecases/profile/get_user_profile_usecase.dart';
import '../../../domain/usecases/profile/update_profile_usecase.dart';
import '../../../domain/usecases/profile/change_password_usecase.dart';
import '../../../domain/usecases/profile/logout_device_usecase.dart';
import '../../../domain/usecases/profile/logout_all_devices_usecase.dart';
import '../../../domain/usecases/profile/delete_device_usecase.dart';
import '../../../domain/usecases/profile/delete_all_devices_usecase.dart';
import '../../../domain/usecases/profile/get_active_devices_usecase.dart';
import '../../../domain/usecases/profile/update_notification_preference_usecase.dart';
import '../../../domain/usecases/profile/get_notification_preference_usecase.dart';
import '../../../data/services/notification_service.dart';
import '../../../data/services/device_info_service.dart';
import '../../../domain/repositories/profile_repository.dart';
import '../../../data/models/profile/request/update_profile_request_model.dart';
import '../../../domain/entities/device.dart';

/// BLoC pro správu profilu uživatele, zařízení a nastavení notifikací.
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetActiveDevicesUseCase _getActiveDevicesUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final LogoutDeviceUseCase _logoutDeviceUseCase;
  final LogoutAllDevicesUseCase _logoutAllDevicesUseCase;
  final DeleteDeviceUseCase _deleteDeviceUseCase;
  final DeleteAllDevicesUseCase _deleteAllDevicesUseCase;
  final UpdateNotificationPreferenceUseCase _updateNotificationPreferenceUseCase;
  final GetNotificationPreferenceUseCase _getNotificationPreferenceUseCase;
  final NotificationService _notificationService;
  final DeviceInfoService _deviceInfoService;
  final ProfileRepository _profileRepository;

  UserBloc({
    required GetUserProfileUseCase getUserProfileUseCase,
    required GetActiveDevicesUseCase getActiveDevicesUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
    required LogoutDeviceUseCase logoutDeviceUseCase,
    required LogoutAllDevicesUseCase logoutAllDevicesUseCase,
    required DeleteDeviceUseCase deleteDeviceUseCase,
    required DeleteAllDevicesUseCase deleteAllDevicesUseCase,
    required UpdateNotificationPreferenceUseCase updateNotificationPreferenceUseCase,
    required GetNotificationPreferenceUseCase getNotificationPreferenceUseCase,
    required NotificationService notificationService,
    required DeviceInfoService deviceInfoService,
    required ProfileRepository profileRepository,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _getActiveDevicesUseCase = getActiveDevicesUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       _changePasswordUseCase = changePasswordUseCase,
       _logoutDeviceUseCase = logoutDeviceUseCase,
       _logoutAllDevicesUseCase = logoutAllDevicesUseCase,
       _deleteDeviceUseCase = deleteDeviceUseCase,
       _deleteAllDevicesUseCase = deleteAllDevicesUseCase,
       _updateNotificationPreferenceUseCase = updateNotificationPreferenceUseCase,
       _getNotificationPreferenceUseCase = getNotificationPreferenceUseCase,
       _notificationService = notificationService,
       _deviceInfoService = deviceInfoService,
       _profileRepository = profileRepository,
       super(const UserState.initial()) {
    // Registrace handlerů
    on<ProfileRequested>(_onProfileRequested);
    on<DevicesRequested>(_onDevicesRequested);
    on<ProfileUpdated>(_onProfileUpdated);
    on<PasswordChangeRequested>(_onPasswordChangeRequested);
    on<AllDevicesLogoutRequested>(_onAllDevicesLogoutRequested);
    on<DeviceLoggedOut>(_onDeviceLoggedOut);
    on<DeviceDeleted>(_onDeviceDeleted);
    on<AllDevicesDeleteRequested>(_onAllDevicesDeleteRequested);

    on<ClearDataRequested>(_onClearDataRequested);
    on<NotificationPreferenceRequested>(_onNotificationPreferenceRequested);
    on<NotificationToggled>(_onNotificationToggled);
    on<ProfilePhotoUploadRequested>(_onProfilePhotoUploadRequested);
  }

  /// Seřadí zařízení: aktuální první, pak aktivní, pak neaktivní (dle lastLogin).
  List<Device> _sortDevices(List<Device> devices) {
    return List.of(devices)..sort((a, b) {
      if (a.isCurrentDevice != b.isCurrentDevice) {
        return a.isCurrentDevice ? -1 : 1;
      }
      if (a.isActive != b.isActive) {
        return a.isActive ? -1 : 1;
      }
      return b.lastLogin.compareTo(a.lastLogin);
    });
  }

  /// Načte profil uživatele a aktualizuje seznam zařízení a nastavení notifikací.
  ///
  /// Pokud je profil již načten, loading state se přeskakuje (zamezí blikání).
  Future<void> _onProfileRequested(
    ProfileRequested event,
    Emitter<UserState> emit,
  ) async {
    final isAlreadyLoaded = state.maybeMap(
      loaded: (_) => true,
      orElse: () => false,
    );

    if (!isAlreadyLoaded) {
      emit(const UserState.loading());
    }

    try {
      final profile = await _getUserProfileUseCase();

      final List<Device> currentDevices = state.maybeWhen(
        loaded: (_, devices, __, ___) => devices,
        orElse: () => <Device>[],
      );

      emit(UserState.loaded(profile: profile, devices: currentDevices));

      try {
        final freshDevices = await _getActiveDevicesUseCase();
        emit(UserState.loaded(profile: profile, devices: _sortDevices(freshDevices)));
      } catch (_) {}

      add(const UserEvent.notificationPreferenceRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// Načte a aktualizuje seznam aktivních zařízení bez ovlivnění zbytku stavu.
  Future<void> _onDevicesRequested(
    DevicesRequested event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state.mapOrNull(loaded: (s) => s);
    if (currentState == null) return;

    try {
      final devices = await _getActiveDevicesUseCase();
      emit(currentState.copyWith(devices: _sortDevices(devices)));
    } catch (e) {
      emit(UserState.failure("Nepodařilo se načíst zařízení: $e"));
    }
  }

  /// Aktualizuje profil uživatele a znovu načte seznam zařízení.
  Future<void> _onProfileUpdated(
    ProfileUpdated event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      final updatedProfile = await _updateProfileUseCase(event.request);
      emit(UserState.loaded(profile: updatedProfile, devices: <Device>[]));
      add(const UserEvent.devicesRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// Provede změnu hesla a znovu načte profil po úspěchu.
  Future<void> _onPasswordChangeRequested(
    PasswordChangeRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    try {
      await _changePasswordUseCase(event.request);
      emit(const UserState.passwordChangeSuccess());
      add(const UserEvent.profileRequested());
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// Odhlásí všechna zařízení kromě aktuálního a obnoví jejich seznam.
  Future<void> _onAllDevicesLogoutRequested(
    AllDevicesLogoutRequested event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state.mapOrNull(loaded: (s) => s);
    try {
      await _logoutAllDevicesUseCase();
      final devices = await _getActiveDevicesUseCase();
      if (currentState != null) {
        emit(currentState.copyWith(devices: _sortDevices(devices)));
      }
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// Odhlásí konkrétní zařízení a obnoví jejich seznam.
  Future<void> _onDeviceLoggedOut(
    DeviceLoggedOut event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state.mapOrNull(loaded: (s) => s);
    try {
      await _logoutDeviceUseCase(event.deviceId);
      final devices = await _getActiveDevicesUseCase();
      if (currentState != null) {
        emit(currentState.copyWith(devices: _sortDevices(devices)));
      }
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// Smaže konkrétní zařízení z DB a obnoví jejich seznam.
  Future<void> _onDeviceDeleted(
    DeviceDeleted event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state.mapOrNull(loaded: (s) => s);
    try {
      await _deleteDeviceUseCase(event.deviceId);
      final devices = await _getActiveDevicesUseCase();
      if (currentState != null) {
        emit(currentState.copyWith(devices: _sortDevices(devices)));
      }
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// Smaže všechna zařízení kromě aktuálního a obnoví jejich seznam.
  Future<void> _onAllDevicesDeleteRequested(
    AllDevicesDeleteRequested event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state.mapOrNull(loaded: (s) => s);
    try {
      await _deleteAllDevicesUseCase();
      final devices = await _getActiveDevicesUseCase();
      if (currentState != null) {
        emit(currentState.copyWith(devices: _sortDevices(devices)));
      }
    } catch (e) {
      emit(UserState.failure(e.toString()));
    }
  }

  /// Nahraje profilovou fotku, aktualizuje profil s novou URL a znovu jej načte.
  /// Pokud existuje stará fotka, smaže ji z úložiště před nahráním nové.
  Future<void> _onProfilePhotoUploadRequested(
    ProfilePhotoUploadRequested event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state.mapOrNull(loaded: (s) => s);
    if (currentState == null) return;

    try {
      // Smazání staré fotky (best-effort, tiché selhání v repozitáři)
      final oldUrl = currentState.profile.profileImageUrl;
      if (oldUrl != null && oldUrl.isNotEmpty) {
        final oldPath = _extractStoragePath(oldUrl);
        if (oldPath != null) {
          await _profileRepository.deleteStorageFile(oldPath);
        }
      }

      final photoUrl = await _profileRepository.uploadProfilePhoto(
        event.imageBytes,
        event.filename,
      );

      await _updateProfileUseCase(UpdateProfileRequestModel(
        firstName: currentState.profile.firstName,
        lastName: currentState.profile.lastName,
        profileImageUrl: photoUrl,
      ));

      add(const UserEvent.profileRequested());
    } catch (e) {
      emit(UserState.failure('Nahrání fotky selhalo: $e'));
      add(const UserEvent.profileRequested());
    }
  }

  /// Extrahuje relativní cestu souboru z URL pro potřeby DELETE volání.
  /// Lokální: http://10.0.2.2:8081/uploads/profile/xyz.jpg → profile/xyz.jpg
  /// GCS:     https://storage.googleapis.com/bucket/profile/xyz.jpg → profile/xyz.jpg
  String? _extractStoragePath(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      // Lokální: ['uploads', 'profile', 'xyz.jpg'] → skip 'uploads'
      if (segments.isNotEmpty && segments.first == 'uploads') {
        return segments.skip(1).join('/');
      }
      // GCS: ['bucket', 'profile', 'xyz.jpg'] → skip bucket name (first segment)
      if (segments.length >= 2) {
        return segments.skip(1).join('/');
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Resetuje BLoC do výchozího stavu (např. po odhlášení).
  Future<void> _onClearDataRequested(
    ClearDataRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.initial());
  }

  /// Načte aktuální stav notifikací z backendu a aktualizuje stav.
  Future<void> _onNotificationPreferenceRequested(
    NotificationPreferenceRequested event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state.mapOrNull(loaded: (s) => s);
    if (currentState == null) return;

    try {
      final deviceId = await _deviceInfoService.getDeviceIdentifier();
      final result = await _getNotificationPreferenceUseCase(
        deviceIdentifier: deviceId,
      );
      final enabled = result['notificationsEnabled'] as bool? ?? false;
      emit(currentState.copyWith(notificationsEnabled: enabled));
    } catch (_) {}
  }

  /// Zapne nebo vypne notifikace — vyžádá OS permission, získá FCM token
  /// a odešle preferenci na backend.
  Future<void> _onNotificationToggled(
    NotificationToggled event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state.mapOrNull(loaded: (s) => s);
    if (currentState == null) return;

    emit(currentState.copyWith(notificationsLoading: true));

    try {
      final deviceId = await _deviceInfoService.getDeviceIdentifier();

      if (event.enabled) {
        final granted = await _notificationService.requestPermission();
        if (!granted) {
          emit(currentState.copyWith(
            notificationsEnabled: false,
            notificationsLoading: false,
          ));
          return;
        }

        final fcmToken = await _notificationService.getToken();
        if (fcmToken == null) {
          emit(currentState.copyWith(
            notificationsEnabled: false,
            notificationsLoading: false,
          ));
          return;
        }

        await _updateNotificationPreferenceUseCase(
          deviceIdentifier: deviceId,
          notificationsEnabled: true,
          fcmToken: fcmToken,
        );

        emit(currentState.copyWith(
          notificationsEnabled: true,
          notificationsLoading: false,
        ));
      } else {
        await _updateNotificationPreferenceUseCase(
          deviceIdentifier: deviceId,
          notificationsEnabled: false,
        );

        emit(currentState.copyWith(
          notificationsEnabled: false,
          notificationsLoading: false,
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(notificationsLoading: false));
      emit(UserState.failure('Nepodařilo se změnit nastavení notifikací: $e'));
      add(const UserEvent.profileRequested());
    }
  }
}
