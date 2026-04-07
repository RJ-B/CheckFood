import '../../repositories/profile_repository.dart';

/// UseCase pro trvalé smazání konkrétního zařízení z DB.
class DeleteDeviceUseCase {
  final ProfileRepository _repository;

  DeleteDeviceUseCase(this._repository);

  Future<void> call(int deviceId) async {
    return await _repository.deleteDevice(deviceId);
  }
}
