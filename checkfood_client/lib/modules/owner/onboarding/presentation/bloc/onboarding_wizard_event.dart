import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/address_model.dart';
import '../../data/models/opening_hours_model.dart';

part 'onboarding_wizard_event.freezed.dart';

@freezed
class OnboardingWizardEvent with _$OnboardingWizardEvent {
  // Navigation
  const factory OnboardingWizardEvent.loadOnboarding() = LoadOnboarding;
  const factory OnboardingWizardEvent.goToStep(int step) = GoToStep;

  // Step 1: Info
  const factory OnboardingWizardEvent.updateInfo({
    required String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  }) = UpdateInfo;

  // Step 2: Hours
  const factory OnboardingWizardEvent.updateHours(List<OpeningHoursModel> hours) = UpdateHours;

  // Step 3: Tables
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

  // Step 4: Menu
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

  // Step 5: Panorama
  const factory OnboardingWizardEvent.createPanoramaSession() = CreatePanoramaSession;
  const factory OnboardingWizardEvent.uploadPhoto({
    required String sessionId,
    required int angleIndex,
    required double actualAngle,
    required Uint8List fileBytes,
    required String filename,
  }) = UploadPhoto;
  const factory OnboardingWizardEvent.finalizePanorama(String sessionId) = FinalizePanorama;
  const factory OnboardingWizardEvent.activatePanorama(String sessionId) = ActivatePanorama;
  const factory OnboardingWizardEvent.loadPanoramaSessions() = LoadPanoramaSessions;
  const factory OnboardingWizardEvent.pollPanoramaStatus(String sessionId) = PollPanoramaStatus;

  // Step 6: Publish
  const factory OnboardingWizardEvent.publish() = Publish;
}
