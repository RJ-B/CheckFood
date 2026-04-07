import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors.dart';

import '../../../../../l10n/generated/app_localizations.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../owner/onboarding/domain/entities/panorama_session.dart';
import '../../../../owner/onboarding/domain/repositories/onboarding_repository.dart';
import '../../../../owner/onboarding/domain/usecases/activate_panorama_usecase.dart';
import '../../../../owner/onboarding/domain/usecases/create_panorama_session_usecase.dart';
import '../../../../owner/onboarding/domain/usecases/get_panorama_status_usecase.dart';
import '../../../../owner/onboarding/domain/usecases/get_tables_usecase.dart';
import '../../../../owner/onboarding/domain/usecases/update_table_usecase.dart';
import '../../../../owner/onboarding/presentation/bloc/onboarding_wizard_bloc.dart';
import '../../../../owner/onboarding/presentation/widgets/panorama_capture_screen.dart';
import '../../../../owner/onboarding/presentation/widgets/panorama_editor_screen.dart';

/// Záložka v dashboardu majitele pro správu panorama sessions:
/// vytváření nových snímků, sledování průběhu stitchingu a aktivaci hotového panoramatu.
class PanoramaTab extends StatefulWidget {
  final String? activePanoramaUrl;

  const PanoramaTab({super.key, this.activePanoramaUrl});

  @override
  State<PanoramaTab> createState() => _PanoramaTabState();
}

class _PanoramaTabState extends State<PanoramaTab> {
  List<PanoramaSession> _sessions = [];
  bool _loading = false;
  bool _creating = false;
  String? _error;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadSessions() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final repo = sl<OnboardingRepository>();
      final sessions = await repo.listPanoramaSessions();
      if (mounted) {
        setState(() {
          _sessions = sessions;
          _loading = false;
        });
        _startPollingIfNeeded();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = e.toString();
        });
      }
    }
  }

  void _startPollingIfNeeded() {
    _pollTimer?.cancel();
    final processingSession = _sessions.where((s) => s.status == 'PROCESSING').firstOrNull;
    if (processingSession != null) {
      _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) => _pollStatus(processingSession.id));
    }
  }

  Future<void> _pollStatus(String sessionId) async {
    try {
      final getStatus = sl<GetPanoramaStatusUseCase>();
      final updated = await getStatus(sessionId);
      if (mounted) {
        setState(() {
          _sessions = _sessions.map((s) => s.id == updated.id ? updated : s).toList();
        });
        if (updated.status != 'PROCESSING') {
          _pollTimer?.cancel();
        }
      }
    } catch (_) {}
  }

  Future<void> _createNewPanorama() async {
    setState(() => _creating = true);
    try {
      final createSession = sl<CreatePanoramaSessionUseCase>();
      final session = await createSession();

      if (!mounted) return;

      await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OnboardingWizardBloc>(),
            child: PanoramaCaptureScreen(sessionId: session.id),
          ),
        ),
      );

      if (!mounted) return;

      await _loadSessions();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).errorGeneric(e.toString())), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  Future<void> _activatePanorama(String sessionId) async {
    final activate = sl<ActivatePanoramaUseCase>();
    await activate(sessionId);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).panoramaActivatedSuccess), backgroundColor: AppColors.success),
      );
      _loadSessions();
    }
  }

  Future<void> _openEditorWithTables(String panoramaUrl) async {
    List<EditorTable> editorTables = [];
    try {
      final getTables = sl<GetTablesUseCase>();
      final tables = await getTables();
      editorTables = tables
          .where((t) => t.yaw != null && t.pitch != null)
          .map((t) => EditorTable(
                id: t.id,
                label: t.label,
                capacity: t.capacity,
                yaw: t.yaw!,
                pitch: t.pitch!,
                isNew: false,
              ))
          .toList();
    } catch (_) {}

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PanoramaEditorScreen(
          panoramaUrl: panoramaUrl,
          existingTables: editorTables,
          onSave: (tables) async {
            final updateTable = sl<UpdateTableUseCase>();
            for (final t in tables) {
              if (t.isNew) continue;
              await updateTable(
                t.id,
                label: t.label,
                capacity: t.capacity,
                yaw: t.yaw,
                pitch: t.pitch,
              );
            }
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).tablePositionsSavedSuccess),
                  backgroundColor: AppColors.success,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _openEditor(PanoramaSession session) {
    if (session.resultUrl == null) return;
    _openEditorWithTables(session.resultUrl!);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 8),
            Text(_error!),
            const SizedBox(height: 16),
            FilledButton(onPressed: _loadSessions, child: Text(S.of(context).retry)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadSessions,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.activePanoramaUrl != null) ...[
            Card(
              color: AppColors.successLight,
              child: ListTile(
                leading: const Icon(Icons.panorama, color: AppColors.success),
                title: Text(S.of(context).activePanoramaTitle),
                subtitle: Text(S.of(context).activePanoramaDesc),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _openEditorWithTables(widget.activePanoramaUrl!),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FilledButton.icon(
              onPressed: _creating ? null : _createNewPanorama,
              icon: _creating
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.add_a_photo),
              label: Text(_creating ? S.of(context).creatingPanorama : S.of(context).newPanoramaButton),
            ),
          ),

          if (_sessions.isEmpty && widget.activePanoramaUrl == null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(S.of(context).noPanoramaYetLong),
              ),
            ),

          ..._sessions.map((session) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    _statusIcon(session.status),
                    color: _statusColor(session.status),
                  ),
                  title: Text(S.of(context).sessionLabel(session.id.substring(0, 8))),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_statusLabel(context, session.status)} | ${S.of(context).photosProgress(session.photoCount, 8)}'),
                      if (session.status == 'PROCESSING')
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: LinearProgressIndicator(),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (session.status == 'COMPLETED') ...[
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _openEditor(session),
                        ),
                        FilledButton(
                          onPressed: () => _activatePanorama(session.id),
                          child: Text(S.of(context).activate),
                        ),
                      ],
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  IconData _statusIcon(String status) => switch (status) {
        'COMPLETED' => Icons.check_circle,
        'PROCESSING' => Icons.hourglass_top,
        'FAILED' => Icons.error,
        _ => Icons.upload,
      };

  Color _statusColor(String status) => switch (status) {
        'COMPLETED' => AppColors.success,
        'PROCESSING' => AppColors.warning,
        'FAILED' => AppColors.error,
        _ => AppColors.textMuted,
      };

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
}
