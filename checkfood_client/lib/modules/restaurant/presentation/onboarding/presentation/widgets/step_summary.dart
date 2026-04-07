import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

/// Onboarding krok 6: souhrnný checklist všech dokončených kroků s tlačítkem
/// pro zveřejnění, které se aktivuje po dokončení všech povinných kroků.
class StepSummary extends StatelessWidget {
  const StepSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardBloc, OnboardingWizardState>(
      builder: (context, state) {
        final status = state.status;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(S.of(context).settingsSummary, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _checkItem(S.of(context).summaryInfo, status?.hasInfo ?? false),
              _checkItem(S.of(context).summaryHours, status?.hasHours ?? false),
              _checkItem(S.of(context).summaryTables, status?.hasTables ?? false),
              _checkItem(S.of(context).summaryMenu, status?.hasMenu ?? false),
              _checkItem(S.of(context).summaryPanorama, status?.hasPanorama ?? false, optional: true),
              const SizedBox(height: 24),
              if (state.published) ...[
                Card(
                  color: AppColors.successLight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            S.of(context).publishedSuccess,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                FilledButton(
                  onPressed: _canPublish(status) && !state.publishing
                      ? () => context.read<OnboardingWizardBloc>().add(
                            const OnboardingWizardEvent.publish(),
                          )
                      : null,
                  child: state.publishing
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(S.of(context).publishRestaurant),
                ),
                if (!_canPublish(status))
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      S.of(context).fillRequiredSteps,
                      style: const TextStyle(color: AppColors.warning),
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  bool _canPublish(dynamic status) {
    if (status == null) return false;
    return status.hasInfo && status.hasHours && status.hasTables && status.hasMenu;
  }

  Widget _checkItem(String label, bool done, {bool optional = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle : (optional ? Icons.radio_button_unchecked : Icons.cancel),
            color: done ? AppColors.success : (optional ? AppColors.textMuted : AppColors.error),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
