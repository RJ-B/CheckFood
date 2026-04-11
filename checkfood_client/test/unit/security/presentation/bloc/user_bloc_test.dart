import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/security/presentation/bloc/user/user_bloc.dart';
import 'package:checkfood_client/security/presentation/bloc/user/user_event.dart';
import 'package:checkfood_client/security/presentation/bloc/user/user_state.dart';
import 'package:checkfood_client/security/domain/entities/user_profile.dart';
import 'package:checkfood_client/security/domain/entities/device.dart';
import 'package:checkfood_client/security/domain/repositories/profile_repository.dart';
import 'package:checkfood_client/security/domain/usecases/profile/get_user_profile_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/update_profile_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/change_password_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/logout_device_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/logout_all_devices_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/delete_device_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/delete_all_devices_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/get_active_devices_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/update_notification_preference_usecase.dart';
import 'package:checkfood_client/security/domain/usecases/profile/get_notification_preference_usecase.dart';
import 'package:checkfood_client/security/data/models/profile/request/update_profile_request_model.dart';
import 'package:checkfood_client/security/data/models/profile/request/change_password_request_model.dart';
import 'package:checkfood_client/security/data/services/notification_service.dart';
import 'package:checkfood_client/security/data/services/device_info_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ---------------------------------------------------------------------------
// Fake profile repository
// ---------------------------------------------------------------------------

class FakeProfileRepository implements ProfileRepository {
  bool shouldThrow = false;
  bool changePasswordShouldThrow = false;
  bool devicesAlwaysEmpty = false;

  final _profile = UserProfile(
    id: 1,
    email: 'test@example.com',
    firstName: 'Jan',
    lastName: 'Novak',
    isActive: true,
    createdAt: DateTime(2024, 1, 1),
    roleName: 'USER',
  );

  final _devices = [
    Device(
      id: 1,
      deviceName: 'iPhone 15',
      deviceType: 'iOS',
      deviceIdentifier: 'dev-1',
      lastLogin: DateTime(2025, 1, 1),
      isCurrentDevice: true,
    ),
    Device(
      id: 2,
      deviceName: 'MacBook Pro',
      deviceType: 'macOS',
      deviceIdentifier: 'dev-2',
      lastLogin: DateTime(2025, 1, 2),
      isCurrentDevice: false,
    ),
  ];

  @override
  Future<UserProfile> getUserProfile() async {
    if (shouldThrow) throw Exception('Profile load failed');
    return _profile;
  }

  @override
  Future<UserProfile> updateProfile(UpdateProfileRequestModel request) async {
    if (shouldThrow) throw Exception('Update failed');
    return _profile.copyWith(
      firstName: request.firstName,
      lastName: request.lastName,
    );
  }

  @override
  Future<void> changePassword(ChangePasswordRequestModel request) async {
    if (changePasswordShouldThrow) throw Exception('Wrong current password');
  }

  @override
  Future<List<Device>> getActiveDevices() async {
    if (shouldThrow) throw Exception('Devices load failed');
    if (devicesAlwaysEmpty) return [];
    return _devices;
  }

  @override
  Future<void> logoutDevice(int deviceId) async {
    if (shouldThrow) throw Exception('Logout device failed');
  }

  @override
  Future<void> deleteDevice(int deviceId) async {
    if (shouldThrow) throw Exception('Delete device failed');
  }

  @override
  Future<void> logoutAllDevices() async {
    if (shouldThrow) throw Exception('Logout all failed');
  }

  @override
  Future<void> deleteAllDevices() async {
    if (shouldThrow) throw Exception('Delete all failed');
  }

  @override
  Future<Map<String, dynamic>> updateNotificationPreference({
    required String deviceIdentifier,
    required bool notificationsEnabled,
    String? fcmToken,
  }) async => {'notificationsEnabled': notificationsEnabled};

  @override
  Future<Map<String, dynamic>> getNotificationPreference({
    required String deviceIdentifier,
  }) async => {'notificationsEnabled': false};

  @override
  Future<String> uploadAvatar(Uint8List imageBytes, String filename) async => 'https://cdn.example.com/avatar.jpg';

  @override
  Future<void> deleteAvatar() async {}

  @override
  Future<void> deleteAccount() async {}
}

// ---------------------------------------------------------------------------
// Fake services
// ---------------------------------------------------------------------------

class FakeNotificationService extends NotificationService {
  bool permissionGranted = true;
  String? token = 'fcm-token-123';

  @override
  Future<bool> requestPermission() async => permissionGranted;

  @override
  Future<String?> getToken() async => token;
}

class FakeDeviceInfoService extends DeviceInfoService {
  FakeDeviceInfoService() : super(const FlutterSecureStorage());

  @override
  Future<String> getDeviceIdentifier() async => 'test-device-id';
}

// ---------------------------------------------------------------------------
// Builder
// ---------------------------------------------------------------------------

UserBloc _buildBloc({
  FakeProfileRepository? repo,
  FakeNotificationService? notificationService,
}) {
  final r = repo ?? FakeProfileRepository();
  final ns = notificationService ?? FakeNotificationService();
  final ds = FakeDeviceInfoService();

  return UserBloc(
    getUserProfileUseCase: GetUserProfileUseCase(r),
    getActiveDevicesUseCase: GetActiveDevicesUseCase(r),
    updateProfileUseCase: UpdateProfileUseCase(r),
    changePasswordUseCase: ChangePasswordUseCase(r),
    logoutDeviceUseCase: LogoutDeviceUseCase(r),
    logoutAllDevicesUseCase: LogoutAllDevicesUseCase(r),
    deleteDeviceUseCase: DeleteDeviceUseCase(r),
    deleteAllDevicesUseCase: DeleteAllDevicesUseCase(r),
    updateNotificationPreferenceUseCase: UpdateNotificationPreferenceUseCase(r),
    getNotificationPreferenceUseCase: GetNotificationPreferenceUseCase(r),
    notificationService: ns,
    deviceInfoService: ds,
    profileRepository: r,
  );
}

bool _isLoaded(UserState s) =>
    s.maybeWhen(loaded: (_, __, ___, ____) => true, orElse: () => false);

bool _isLoading(UserState s) =>
    s.maybeWhen(loading: () => true, orElse: () => false);

bool _isFailure(UserState s) =>
    s.maybeWhen(failure: (_) => true, orElse: () => false);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('UserBloc — initial state', () {
    test('should start with UserState.initial', () {
      final bloc = _buildBloc();
      expect(
        bloc.state,
        equals(const UserState.initial()),
      );
      bloc.close();
    });
  });

  group('UserBloc — ProfileRequested', () {
    test('should emit loading then loaded with profile and devices', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());

      await expectLater(
        bloc.stream,
        emitsThrough(
          isA<UserState>().having(_isLoaded, 'loaded', isTrue),
        ),
      );

      bloc.state.maybeWhen(
        loaded: (profile, devices, _, __) {
          expect(profile.email, 'test@example.com');
          expect(devices, isNotEmpty);
        },
        orElse: () => fail('Expected loaded state'),
      );
      bloc.close();
    });

    test('should skip loading when already loaded (no blink)', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      // Second request — should NOT emit loading again
      final states = <UserState>[];
      final sub = bloc.stream.listen(states.add);
      bloc.add(const UserEvent.profileRequested());
      await Future.delayed(const Duration(milliseconds: 100));
      await sub.cancel();

      expect(states.any(_isLoading), isFalse);
      bloc.close();
    });

    test('should emit failure when profile load throws', () async {
      final repo = FakeProfileRepository()..shouldThrow = true;
      final bloc = _buildBloc(repo: repo);
      bloc.add(const UserEvent.profileRequested());
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<UserState>().having(_isLoading, 'loading', isTrue),
          isA<UserState>().having(_isFailure, 'failure', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  group('UserBloc — ProfileUpdated', () {
    test('should emit loading then loaded with updated name', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileUpdated(
        UpdateProfileRequestModel(firstName: 'Updated', lastName: 'Name'),
      ));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<UserState>().having(_isLoading, 'loading', isTrue),
          isA<UserState>().having(_isLoaded, 'loaded', isTrue),
        ]),
      );
      bloc.state.maybeWhen(
        loaded: (profile, _, __, ___) => expect(profile.firstName, 'Updated'),
        orElse: () => fail('Expected loaded'),
      );
      bloc.close();
    });

    test('should emit failure on update error', () async {
      final repo = FakeProfileRepository()..shouldThrow = true;
      final bloc = _buildBloc(repo: repo);
      bloc.add(const UserEvent.profileUpdated(
        UpdateProfileRequestModel(firstName: 'X', lastName: 'Y'),
      ));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<UserState>().having(_isLoading, 'loading', isTrue),
          isA<UserState>().having(_isFailure, 'failure', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  group('UserBloc — PasswordChangeRequested', () {
    test('should emit loading then passwordChangeSuccess', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.passwordChangeRequested(
        ChangePasswordRequestModel(
          currentPassword: 'OldP@ss1!',
          newPassword: 'NewP@ss1!',
          confirmPassword: 'NewP@ss1!',
        ),
      ));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<UserState>().having(_isLoading, 'loading', isTrue),
          isA<UserState>().having(
            (s) => s.maybeWhen(passwordChangeSuccess: () => true, orElse: () => false),
            'passwordChangeSuccess',
            isTrue,
          ),
        ]),
      );
      bloc.close();
    });

    test('should emit failure when current password is wrong', () async {
      final repo = FakeProfileRepository()..changePasswordShouldThrow = true;
      final bloc = _buildBloc(repo: repo);
      bloc.add(const UserEvent.passwordChangeRequested(
        ChangePasswordRequestModel(
          currentPassword: 'wrong',
          newPassword: 'NewP@ss1!',
          confirmPassword: 'NewP@ss1!',
        ),
      ));
      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<UserState>().having(_isLoading, 'loading', isTrue),
          isA<UserState>().having(_isFailure, 'failure', isTrue),
        ]),
      );
      bloc.close();
    });
  });

  group('UserBloc — DeviceManagement', () {
    test('DeviceLoggedOut should reload devices', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.deviceLoggedOut(2));
      await bloc.stream.firstWhere(_isLoaded);

      bloc.state.maybeWhen(
        loaded: (_, devices, __, ___) => expect(devices, isNotEmpty),
        orElse: () => fail('Expected loaded'),
      );
      bloc.close();
    });

    test('DeviceDeleted should reload devices', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.deviceDeleted(2));
      await bloc.stream.firstWhere(_isLoaded);
      bloc.close();
    });

    test('AllDevicesLogoutRequested should reload devices', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.allDevicesLogoutRequested());
      await bloc.stream.firstWhere(_isLoaded);
      bloc.close();
    });

    test('AllDevicesDeleteRequested should reload devices', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.allDevicesDeleteRequested());
      await bloc.stream.firstWhere(_isLoaded);
      bloc.close();
    });

    test('devices sorted: current device first', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.state.maybeWhen(
        loaded: (_, devices, __, ___) {
          if (devices.isNotEmpty) {
            expect(devices.first.isCurrentDevice, isTrue);
          }
        },
        orElse: () {},
      );
      bloc.close();
    });

    test('DeviceLoggedOut ignored when state is not loaded', () async {
      final bloc = _buildBloc();
      // State is initial — event should be silently ignored
      bloc.add(const UserEvent.deviceLoggedOut(1));
      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        bloc.state.maybeWhen(initial: () => true, orElse: () => false),
        isTrue,
      );
      bloc.close();
    });
  });

  group('UserBloc — NotificationToggled', () {
    test('should update notificationsEnabled to true when permission granted', () async {
      final repo = FakeProfileRepository();
      final ns = FakeNotificationService()
        ..permissionGranted = true
        ..token = 'fcm-token';
      final bloc = _buildBloc(repo: repo, notificationService: ns);
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.notificationToggled(true));
      await bloc.stream.firstWhere(
        (s) => s.maybeWhen(
          loaded: (_, __, enabled, ___) => enabled == true,
          orElse: () => false,
        ),
      );
      bloc.close();
    });

    test('should not enable notifications when permission denied', () async {
      final ns = FakeNotificationService()..permissionGranted = false;
      final bloc = _buildBloc(notificationService: ns);
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.notificationToggled(true));
      await bloc.stream.firstWhere(
        (s) => s.maybeWhen(
          loaded: (_, __, enabled, loading) => !loading,
          orElse: () => false,
        ),
      );
      bloc.state.maybeWhen(
        loaded: (_, __, enabled, ___) => expect(enabled, isFalse),
        orElse: () {},
      );
      bloc.close();
    });

    test('should not enable notifications when FCM token is null', () async {
      final ns = FakeNotificationService()
        ..permissionGranted = true
        ..token = null;
      final bloc = _buildBloc(notificationService: ns);
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.notificationToggled(true));
      await bloc.stream.firstWhere(
        (s) => s.maybeWhen(
          loaded: (_, __, enabled, loading) => !loading,
          orElse: () => false,
        ),
      );
      bloc.state.maybeWhen(
        loaded: (_, __, enabled, ___) => expect(enabled, isFalse),
        orElse: () {},
      );
      bloc.close();
    });

    test('should disable notifications when toggled false', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.notificationToggled(false));
      await bloc.stream.firstWhere(
        (s) => s.maybeWhen(
          loaded: (_, __, enabled, loading) => !loading && !enabled,
          orElse: () => false,
        ),
      );
      bloc.close();
    });
  });

  group('UserBloc — ClearDataRequested', () {
    test('should return to initial state', () async {
      final bloc = _buildBloc();
      bloc.add(const UserEvent.profileRequested());
      await bloc.stream.firstWhere(_isLoaded);

      bloc.add(const UserEvent.clearDataRequested());
      await expectLater(
        bloc.stream,
        emitsThrough(isA<UserState>().having(
          (s) => s.maybeWhen(initial: () => true, orElse: () => false),
          'initial',
          isTrue,
        )),
      );
      bloc.close();
    });
  });
}
