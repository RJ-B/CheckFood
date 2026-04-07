import '../../entities/device.dart';
import '../../repositories/profile_repository.dart';

/// UseCase pro načtení seznamu aktivních zařízení přihlášeného uživatele.
class GetActiveDevicesUseCase {
  final ProfileRepository _repository;

  GetActiveDevicesUseCase(this._repository);

  /// Vrátí seznam [Device] objektů přiřazených k účtu.
  Future<List<Device>> call() async {
    return await _repository.getActiveDevices();
  }
}
