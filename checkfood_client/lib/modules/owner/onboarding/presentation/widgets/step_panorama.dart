import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

class StepPanorama extends StatefulWidget {
  const StepPanorama({super.key});

  @override
  State<StepPanorama> createState() => _StepPanoramaState();
}

class _StepPanoramaState extends State<StepPanorama> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardBloc, OnboardingWizardState>(
      builder: (context, state) {
        if (!_loaded && !state.loading) {
          _loaded = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<OnboardingWizardBloc>().add(const OnboardingWizardEvent.loadPanoramaSessions());
          });
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Panorama (volitelné)', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              const Text('Panoramatický snímek restaurace pomůže zákazníkům si místo prohlédnout.'),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: state.loading
                    ? null
                    : () {
                        context.read<OnboardingWizardBloc>().add(
                          const OnboardingWizardEvent.createPanoramaSession(),
                        );
                      },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Nové panorama'),
              ),
              const SizedBox(height: 16),
              if (state.sessions.isNotEmpty) ...[
                Text('Existující sezení:', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                ...state.sessions.map((session) => Card(
                  child: ListTile(
                    title: Text('Sezení ${session.id.substring(0, 8)}...'),
                    subtitle: Text('Stav: ${session.status}, Fotek: ${session.photoCount}/8'),
                    trailing: session.status == 'COMPLETED'
                        ? FilledButton(
                            onPressed: () => context
                                .read<OnboardingWizardBloc>()
                                .add(OnboardingWizardEvent.activatePanorama(session.id)),
                            child: const Text('Aktivovat'),
                          )
                        : null,
                  ),
                )),
              ],
              if (state.status?.hasPanorama == true)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Panorama je aktivní'),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
