import '../../entities/device.dart';
import '../../repositories/profile_repository.dart';

class GetActiveDevicesUseCase {
  final ProfileRepository _repository;

  GetActiveDevicesUseCase(this._repository);

  /// Zavolá repozitář a vrátí seznam zařízení
  Future<List<Device>> call() async {
    return await _repository.getActiveDevices();
  }
}
