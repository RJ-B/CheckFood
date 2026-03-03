import '../../repositories/profile_repository.dart';

/// UseCase pro vzdálené odhlášení konkrétního zařízení.
///
/// Umožňuje ukončit relaci jiného zařízení na základě jeho [deviceId].
class LogoutDeviceUseCase {
  final ProfileRepository _repository;

  LogoutDeviceUseCase(this._repository);

  /// Provede odhlášení vybraného zařízení voláním repozitáře.
  /// ✅ OPRAVA: Parametr změněn na int (odpovídá Java Long).
  Future<void> call(int deviceId) async {
    return await _repository.logoutDevice(deviceId);
  }
}
