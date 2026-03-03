// Import entity Device (musí sedět cesta k Security/Domain/Entities)
import '../../../../security/domain/entities/device.dart';

// Import tvého existujícího repozitáře
import '../../repositories/profile_repository.dart';

class GetUserDevicesUseCase {
  final ProfileRepository _repository;

  GetUserDevicesUseCase(this._repository);

  /// Načte a vrátí seznam zařízení [List<Device>].
  Future<List<Device>> call() async {
    return await _repository.getActiveDevices();
  }
}
