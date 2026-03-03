import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';
import '../widgets/step_info_form.dart';
import '../widgets/step_hours_form.dart';
import '../widgets/step_tables_form.dart';
import '../widgets/step_menu_form.dart';
import '../widgets/step_panorama.dart';
import '../widgets/step_summary.dart';

class OnboardingWizardPage extends StatelessWidget {
  const OnboardingWizardPage({super.key});

  static const _stepTitles = [
    'Informace',
    'Otevírací hodiny',
    'Stoly',
    'Menu',
    'Panorama',
    'Souhrn',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<OnboardingWizardBloc>()
        ..add(const OnboardingWizardEvent.loadOnboarding()),
      child: BlocConsumer<OnboardingWizardBloc, OnboardingWizardState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
            );
          }
          if (state.published) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Restaurace byla publikována!'), backgroundColor: Colors.green),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_stepTitles[state.currentStep]),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4),
                child: LinearProgressIndicator(
                  value: (state.currentStep + 1) / _stepTitles.length,
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
            bottomNavigationBar: _buildBottomBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, OnboardingWizardState state) {
    final bloc = context.read<OnboardingWizardBloc>();
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
                  child: const Text('Zpět'),
                ),
              ),
            if (state.currentStep > 0) const SizedBox(width: 12),
            if (state.currentStep < _stepTitles.length - 1)
              Expanded(
                child: FilledButton(
                  onPressed: state.loading
                      ? null
                      : () => bloc.add(OnboardingWizardEvent.goToStep(state.currentStep + 1)),
                  child: const Text('Další'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
