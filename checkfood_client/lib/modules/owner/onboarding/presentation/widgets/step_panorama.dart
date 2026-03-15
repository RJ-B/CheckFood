import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/generated/app_localizations.dart';
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
              Text(S.of(context).panoramaOptionalTitle, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(S.of(context).panoramaHelpText),
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
                label: Text(S.of(context).newPanoramaButton),
              ),
              const SizedBox(height: 16),
              if (state.sessions.isNotEmpty) ...[
                Text(S.of(context).existingSessions, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                ...state.sessions.map((session) => _buildSessionCard(context, session, state)),
              ],
              if (state.status?.hasPanorama == true)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(S.of(context).panoramaIsActive),
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
        title: Text(S.of(context).sessionLabel(session.id.substring(0, 8))),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${_statusLabel(context, session.status)}, ${S.of(context).photosProgress(session.photoCount, 8)}'),
            if (session.status == 'PROCESSING')
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: LinearProgressIndicator(),
              ),
            if (session.status == 'FAILED')
              Text(S.of(context).stitchingFailed, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
        trailing: _buildSessionAction(context, session, state),
      ),
    );
  }

  String _statusLabel(BuildContext context, String status) {
    final l = S.of(context);
    return switch (status) {
      'UPLOADING' => l.statusUploading,
      'PROCESSING' => l.statusProcessing,
      'COMPLETED' => l.statusCompletedShort,
      'FAILED' => l.statusFailed,
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
        child: Text(S.of(context).activate),
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
