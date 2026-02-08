import '../../entities/device.dart';
import '../../repositories/profile_repository.dart';

/// UseCase pro načtení seznamu všech aktivních zařízení uživatele.
///
/// Umožňuje uživateli přehled o tom, kde všude je ke svému účtu přihlášen.
class GetActiveDevicesUseCase {
  final ProfileRepository _repository;

  GetActiveDevicesUseCase(this._repository);

  /// Načte a vrátí seznam entit [Device].
  Future<List<Device>> call() async {
    return await _repository.getActiveDevices();
  }
}
