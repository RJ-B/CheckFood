import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';
import '../widgets/step_info_form.dart';
import '../widgets/step_hours_form.dart';
import '../widgets/step_tables_form.dart';
import '../widgets/step_menu_form.dart';
import '../widgets/step_panorama.dart';
import '../widgets/step_summary.dart';

/// Vícekrokový průvodce onboardingem provázející nového majitele restaurace
/// konfigurací základních informací, otevíracích dob, stolů, menu, panoramatu
/// a zveřejněním restaurace.
class OnboardingWizardPage extends StatelessWidget {
  const OnboardingWizardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final stepTitles = [
      l.stepInfo,
      l.stepHours,
      l.stepTables,
      l.stepMenu,
      l.stepPanorama,
      l.stepSummary,
    ];

    return BlocProvider(
      create: (_) => GetIt.I<OnboardingWizardBloc>()
        ..add(const OnboardingWizardEvent.loadOnboarding()),
      child: BlocConsumer<OnboardingWizardBloc, OnboardingWizardState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: AppColors.error),
            );
          }
          if (state.published) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).restaurantPublished), backgroundColor: AppColors.success),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(stepTitles[state.currentStep]),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4),
                child: LinearProgressIndicator(
                  value: (state.currentStep + 1) / stepTitles.length,
                ),
              ),
            ),
            body: state.loading && state.restaurant == null
                ? const Center(child: CircularProgressIndicator())
                : IndexedStack(
                    index: state.currentStep,
                    children: const [
                      StepInfoForm(),
                      StepHoursForm(),
                      StepTablesForm(),
                      StepMenuForm(),
                      StepPanorama(),
                      StepSummary(),
                    ],
                  ),
            bottomNavigationBar: _buildBottomBar(context, state, stepTitles),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, OnboardingWizardState state, List<String> stepTitles) {
    final bloc = context.read<OnboardingWizardBloc>();
    final l = S.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (state.currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: state.loading
                      ? null
                      : () => bloc.add(OnboardingWizardEvent.goToStep(state.currentStep - 1)),
                  child: Text(l.back),
                ),
              ),
            if (state.currentStep > 0) const SizedBox(width: 12),
            if (state.currentStep < stepTitles.length - 1)
              Expanded(
                child: FilledButton(
                  onPressed: state.loading
                      ? null
                      : () => bloc.add(OnboardingWizardEvent.goToStep(state.currentStep + 1)),
                  child: Text(l.next),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
