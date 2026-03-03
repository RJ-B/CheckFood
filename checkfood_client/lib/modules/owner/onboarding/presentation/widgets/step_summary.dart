import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

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
              Text('Souhrn nastavení', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _checkItem('Informace o restauraci', status?.hasInfo ?? false),
              _checkItem('Otevírací hodiny', status?.hasHours ?? false),
              _checkItem('Alespoň 1 stůl', status?.hasTables ?? false),
              _checkItem('Alespoň 1 položka v menu', status?.hasMenu ?? false),
              _checkItem('Panorama (volitelné)', status?.hasPanorama ?? false, optional: true),
              const SizedBox(height: 24),
              if (state.published) ...[
                const Card(
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Restaurace byla úspěšně publikována!',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      : const Text('Publikovat restauraci'),
                ),
                if (!_canPublish(status))
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Vyplňte všechny povinné kroky před publikací.',
                      style: TextStyle(color: Colors.orange),
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
            color: done ? Colors.green : (optional ? Colors.grey : Colors.red),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}
