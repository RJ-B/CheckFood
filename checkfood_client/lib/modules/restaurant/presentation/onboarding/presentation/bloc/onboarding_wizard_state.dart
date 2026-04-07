import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/restaurant_response_model.dart';
import '../../domain/entities/onboarding_menu_category.dart';
import '../../domain/entities/onboarding_status.dart';
import '../../domain/entities/onboarding_table.dart';
import '../../../../../panorama/domain/entities/panorama_session.dart';

part 'onboarding_wizard_state.freezed.dart';

@freezed
class OnboardingWizardState with _$OnboardingWizardState {
  const factory OnboardingWizardState({
    @Default(0) int currentStep,
    @Default(false) bool loading,
    String? error,
    OnboardingStatus? status,
    OwnerRestaurantResponseModel? restaurant,
    @Default([]) List<OnboardingTable> tables,
    @Default([]) List<OnboardingMenuCategory> categories,
    @Default([]) List<PanoramaSession> sessions,
    PanoramaSession? activeSession,
    @Default(false) bool publishing,
    @Default(false) bool published,
  }) = _OnboardingWizardState;
}
