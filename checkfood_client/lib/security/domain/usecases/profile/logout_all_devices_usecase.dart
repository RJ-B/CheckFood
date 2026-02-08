import '../../repositories/profile_repository.dart';

class LogoutAllDevicesUseCase {
  final ProfileRepository _repository;

  LogoutAllDevicesUseCase(this._repository);

  Future<void> call() async {
    return await _repository.logoutAllDevices();
  }
}
