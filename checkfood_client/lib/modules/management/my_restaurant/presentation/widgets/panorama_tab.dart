import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../owner/onboarding/domain/entities/panorama_session.dart';
import '../../../../owner/onboarding/domain/repositories/onboarding_repository.dart';
import '../../../../owner/onboarding/domain/usecases/activate_panorama_usecase.dart';
import '../../../../owner/onboarding/domain/usecases/get_panorama_status_usecase.dart';
import '../../../../owner/onboarding/presentation/widgets/panorama_editor_screen.dart';

class PanoramaTab extends StatefulWidget {
  final String? activePanoramaUrl;

  const PanoramaTab({super.key, this.activePanoramaUrl});

  @override
  State<PanoramaTab> createState() => _PanoramaTabState();
}

class _PanoramaTabState extends State<PanoramaTab> {
  List<PanoramaSession> _sessions = [];
  bool _loading = false;
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

  Future<void> _activatePanorama(String sessionId) async {
    final activate = sl<ActivatePanoramaUseCase>();
    await activate(sessionId);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Panorama aktivovano!'), backgroundColor: Colors.green),
      );
      _loadSessions();
    }
  }

  void _openEditor(PanoramaSession session) {
    if (session.resultUrl == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PanoramaEditorScreen(
          panoramaUrl: session.resultUrl!,
          existingTables: const [],
          onSave: (tables) async {
            // Tables saved via API calls in the editor
            debugPrint('[PanoramaTab] Saved ${tables.length} tables');
          },
        ),
      ),
    );
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
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 8),
            Text(_error!),
            const SizedBox(height: 16),
            FilledButton(onPressed: _loadSessions, child: const Text('Zkusit znovu')),
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
              color: Colors.green.shade50,
              child: ListTile(
                leading: const Icon(Icons.panorama, color: Colors.green),
                title: const Text('Aktivni panorama'),
                subtitle: const Text('Panorama je nastaveno a zobrazuje se zakaznikum.'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PanoramaEditorScreen(
                        panoramaUrl: widget.activePanoramaUrl!,
                        existingTables: const [],
                        onSave: (tables) async {
                          debugPrint('[PanoramaTab] Saved ${tables.length} tables');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          const SizedBox(height: 8),

          if (_sessions.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('Zatim zadne panorama. Vytvorte ho v onboarding wizard.'),
              ),
            ),

          ..._sessions.map((session) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    _statusIcon(session.status),
                    color: _statusColor(session.status),
                  ),
                  title: Text('Sezeni ${session.id.substring(0, 8)}...'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_statusLabel(session.status)} | ${session.photoCount}/8 fotek'),
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
                          child: const Text('Aktivovat'),
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
        'COMPLETED' => Colors.green,
        'PROCESSING' => Colors.orange,
        'FAILED' => Colors.red,
        _ => Colors.grey,
      };

  String _statusLabel(String status) => switch (status) {
        'UPLOADING' => 'Nahravani',
        'PROCESSING' => 'Zpracovani...',
        'COMPLETED' => 'Dokonceno',
        'FAILED' => 'Selhalo',
        _ => status,
      };
}
