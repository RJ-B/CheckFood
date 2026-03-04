import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';
import 'panorama_capture_screen.dart';

class StepPanorama extends StatefulWidget {
  const StepPanorama({super.key});

  @override
  State<StepPanorama> createState() => _StepPanoramaState();
}

class _StepPanoramaState extends State<StepPanorama> {
  bool _loaded = false;
  final Set<String> _pollingSessionIds = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingWizardBloc, OnboardingWizardState>(
      listenWhen: (prev, curr) {
        // Navigate to camera when a new session is created
        if (prev.activeSession == null && curr.activeSession != null &&
            curr.activeSession!.status == 'UPLOADING') {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state.activeSession != null && state.activeSession!.status == 'UPLOADING') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<OnboardingWizardBloc>(),
                child: PanoramaCaptureScreen(sessionId: state.activeSession!.id),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (!_loaded && !state.loading) {
          _loaded = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<OnboardingWizardBloc>().add(const OnboardingWizardEvent.loadPanoramaSessions());
          });
        }

        // Start polling for any PROCESSING session
        _startPollingIfNeeded(context, state);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Panorama (volitelne)', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              const Text('Panoramaticky snimek restaurace pomuze zakaznikum si misto prohlednout.'),
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
                label: const Text('Nove panorama'),
              ),
              const SizedBox(height: 16),
              if (state.sessions.isNotEmpty) ...[
                Text('Existujici sezeni:', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                ...state.sessions.map((session) => _buildSessionCard(context, session, state)),
              ],
              if (state.status?.hasPanorama == true)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Panorama je aktivni'),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _startPollingIfNeeded(BuildContext context, OnboardingWizardState state) {
    for (final session in state.sessions) {
      if (session.status == 'PROCESSING' && !_pollingSessionIds.contains(session.id)) {
        _pollingSessionIds.add(session.id);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<OnboardingWizardBloc>().add(
            OnboardingWizardEvent.pollPanoramaStatus(session.id),
          );
        });
      }
      if (session.status != 'PROCESSING') {
        _pollingSessionIds.remove(session.id);
      }
    }
  }

  Widget _buildSessionCard(BuildContext context, dynamic session, OnboardingWizardState state) {
    final statusColor = switch (session.status as String) {
      'COMPLETED' => Colors.green,
      'PROCESSING' => Colors.orange,
      'FAILED' => Colors.red,
      _ => Colors.grey,
    };

    final statusIcon = switch (session.status as String) {
      'COMPLETED' => Icons.check_circle,
      'PROCESSING' => Icons.hourglass_top,
      'FAILED' => Icons.error,
      _ => Icons.upload,
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor),
        title: Text('Sezeni ${session.id.substring(0, 8)}...'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stav: ${_statusLabel(session.status)}, Fotek: ${session.photoCount}/8'),
            if (session.status == 'PROCESSING')
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: LinearProgressIndicator(),
              ),
            if (session.status == 'FAILED')
              const Text('Stitching selhal. Zkuste to znovu.', style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
        trailing: _buildSessionAction(context, session, state),
      ),
    );
  }

  String _statusLabel(String status) {
    return switch (status) {
      'UPLOADING' => 'Nahravani',
      'PROCESSING' => 'Zpracovani...',
      'COMPLETED' => 'Dokonceno',
      'FAILED' => 'Selhalo',
      _ => status,
    };
  }

  Widget? _buildSessionAction(BuildContext context, dynamic session, OnboardingWizardState state) {
    if (session.status == 'COMPLETED') {
      return FilledButton(
        onPressed: state.loading
            ? null
            : () => context.read<OnboardingWizardBloc>().add(
                  OnboardingWizardEvent.activatePanorama(session.id),
                ),
        child: const Text('Aktivovat'),
      );
    }

    if (session.status == 'UPLOADING') {
      return IconButton(
        icon: const Icon(Icons.camera_alt),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<OnboardingWizardBloc>(),
                child: PanoramaCaptureScreen(sessionId: session.id),
              ),
            ),
          );
        },
      );
    }

    return null;
  }
}
