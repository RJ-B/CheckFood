import 'dart:typed_data';

import '../entities/onboarding_menu_category.dart';
import '../entities/onboarding_menu_item.dart';
import '../entities/onboarding_status.dart';
import '../entities/onboarding_table.dart';
import '../../../../../panorama/domain/entities/panorama_photo.dart';
import '../../../../../panorama/domain/entities/panorama_session.dart';
import '../../data/models/restaurant_response_model.dart';
import '../../data/models/address_model.dart';
import '../../data/models/opening_hours_model.dart';

/// Doménový kontrakt pro průvodce onboardingem restaurace: základní informace,
/// otevírací doby, stoly, menu, stav onboardingu a panorama sessions.
abstract class OnboardingRepository {
  Future<OwnerRestaurantResponseModel> getMyRestaurant();
  Future<OwnerRestaurantResponseModel> updateInfo({
    required String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  });
  Future<OwnerRestaurantResponseModel> updateHours(List<OpeningHoursModel> hours);

  Future<List<OnboardingTable>> getTables();
  Future<OnboardingTable> addTable({required String label, required int capacity, bool active = true});
  Future<OnboardingTable> updateTable(String id, {required String label, required int capacity, bool active = true, double? yaw, double? pitch});
  Future<void> deleteTable(String id);

  Future<List<OnboardingMenuCategory>> getMenu();
  Future<OnboardingMenuCategory> createCategory({required String name, int sortOrder = 0});
  Future<OnboardingMenuCategory> updateCategory(String id, {required String name, int sortOrder = 0});
  Future<void> deleteCategory(String id);
  Future<OnboardingMenuItem> createItem(String categoryId, {
    required String name,
    String? description,
    int priceMinor = 0,
    String currency = 'CZK',
    String? imageUrl,
    bool available = true,
    int sortOrder = 0,
  });
  Future<OnboardingMenuItem> updateItem(String id, {
    required String name,
    String? description,
    int priceMinor = 0,
    String currency = 'CZK',
    String? imageUrl,
    bool available = true,
    int sortOrder = 0,
  });
  Future<void> deleteItem(String id);

  Future<OnboardingStatus> getOnboardingStatus();
  Future<OwnerRestaurantResponseModel> publish();

  Future<PanoramaSession> createPanoramaSession();
  Future<PanoramaPhoto> uploadPhoto(String sessionId, int angleIndex, double actualAngle, double? actualPitch, Uint8List fileBytes, String filename);
  Future<PanoramaSession> finalizePanoramaSession(String sessionId);
  Future<PanoramaSession> getPanoramaSessionStatus(String sessionId);
  Future<List<PanoramaSession>> listPanoramaSessions();
  Future<void> activatePanorama(String sessionId);
}
