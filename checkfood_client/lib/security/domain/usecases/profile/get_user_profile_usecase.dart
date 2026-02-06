import '../../entities/user_profile.dart';
import '../../repositories/profile_repository.dart';

/// UseCase pro získání detailních informací o profilu uživatele.
///
/// Na rozdíl od GetAuthenticatedUser provádí tento UseCase
/// reálný síťový požadavek pro získání nejaktuálnějších dat ze serveru.
class GetUserProfileUseCase {
  final ProfileRepository _repository;

  GetUserProfileUseCase(this._repository);

  /// Načte a vrátí detailní profil uživatele [UserProfile].
  Future<UserProfile> call() async {
    return await _repository.getUserProfile();
  }
}
