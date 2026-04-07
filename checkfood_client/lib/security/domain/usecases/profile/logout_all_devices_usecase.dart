import '../../repositories/profile_repository.dart';

/// UseCase pro vzdálené odhlášení všech zařízení kromě aktuálního.
class LogoutAllDevicesUseCase {
  final ProfileRepository _repository;

  LogoutAllDevicesUseCase(this._repository);

  Future<void> call() async {
    return await _repository.logoutAllDevices();
  }
}
