import '../../repositories/profile_repository.dart';

/// UseCase pro vzdálené odhlášení konkrétního zařízení.
///
/// Umožňuje ukončit relaci jiného zařízení na základě jeho [deviceId].
class LogoutDeviceUseCase {
  final ProfileRepository _repository;

  LogoutDeviceUseCase(this._repository);

  /// Provede odhlášení vybraného zařízení voláním repozitáře.
  Future<void> call(String deviceId) async {
    return await _repository.logoutDevice(deviceId);
  }
}
