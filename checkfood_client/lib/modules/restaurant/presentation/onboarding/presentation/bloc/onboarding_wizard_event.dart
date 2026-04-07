import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/address_model.dart';
import '../../data/models/opening_hours_model.dart';

part 'onboarding_wizard_event.freezed.dart';

@freezed
class OnboardingWizardEvent with _$OnboardingWizardEvent {
  const factory OnboardingWizardEvent.loadOnboarding() = LoadOnboarding;
  const factory OnboardingWizardEvent.goToStep(int step) = GoToStep;

  const factory OnboardingWizardEvent.updateInfo({
    required String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  }) = UpdateInfo;

  const factory OnboardingWizardEvent.updateHours(List<OpeningHoursModel> hours) = UpdateHours;

  const factory OnboardingWizardEvent.loadTables() = LoadTables;
  const factory OnboardingWizardEvent.addTable({
    required String label,
    required int capacity,
  }) = AddTable;
  const factory OnboardingWizardEvent.updateTable({
    required String id,
    required String label,
    required int capacity,
  }) = UpdateTable;
  const factory OnboardingWizardEvent.deleteTable(String id) = DeleteTable;

  const factory OnboardingWizardEvent.loadMenu() = LoadMenu;
  const factory OnboardingWizardEvent.createCategory(String name) = CreateCategory;
  const factory OnboardingWizardEvent.updateCategory({
    required String id,
    required String name,
  }) = UpdateCategory;
  const factory OnboardingWizardEvent.deleteCategory(String id) = DeleteCategory;
  const factory OnboardingWizardEvent.createItem({
    required String categoryId,
    required String name,
    String? description,
    required int priceMinor,
  }) = CreateItem;
  const factory OnboardingWizardEvent.updateItem({
    required String id,
    required String name,
    String? description,
    required int priceMinor,
  }) = UpdateItem;
  const factory OnboardingWizardEvent.deleteItem(String id) = DeleteItem;

  const factory OnboardingWizardEvent.createPanoramaSession() = CreatePanoramaSession;
  const factory OnboardingWizardEvent.uploadPhoto({
    required String sessionId,
    required int angleIndex,
    required double actualAngle,
    double? actualPitch,
    required Uint8List fileBytes,
    required String filename,
  }) = UploadPhoto;
  const factory OnboardingWizardEvent.finalizePanorama(String sessionId) = FinalizePanorama;
  const factory OnboardingWizardEvent.activatePanorama(String sessionId) = ActivatePanorama;
  const factory OnboardingWizardEvent.loadPanoramaSessions() = LoadPanoramaSessions;
  const factory OnboardingWizardEvent.pollPanoramaStatus(String sessionId) = PollPanoramaStatus;

  const factory OnboardingWizardEvent.publish() = Publish;
}
