import '../../repositories/profile_repository.dart';

/// UseCase pro trvalé smazání všech zařízení kromě aktuálního z DB.
class DeleteAllDevicesUseCase {
  final ProfileRepository _repository;

  DeleteAllDevicesUseCase(this._repository);

  Future<void> call() async {
    return await _repository.deleteAllDevices();
  }
}
