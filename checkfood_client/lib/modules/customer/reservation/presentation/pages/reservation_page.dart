import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../../../../../navigation/main_shell.dart';
import '../../presentation/bloc/my_reservations_bloc.dart';
import '../../presentation/bloc/my_reservations_event.dart';
import '../bloc/reservation_bloc.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_state.dart';
import '../widgets/table_bottom_sheet.dart';

class ReservationPage extends StatefulWidget {
  final String restaurantId;

  const ReservationPage({super.key, required this.restaurantId});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late final ReservationBloc _bloc;
  late final WebViewController _webController;
  bool _webViewReady = false;
  bool _bottomSheetOpen = false;
  bool _scenePushed = false;
  List _lastPushedStatuses = const [];

  @override
  void initState() {
    super.initState();
    _bloc = sl<ReservationBloc>();
    _bloc.add(ReservationEvent.loadScene(restaurantId: widget.restaurantId));
    _initWebView();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  // ── WebView setup (once in initState) ──────────────────────────────

  void _initWebView() {
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'ReservationChannel',
        onMessageReceived: _onJsMessage,
      )
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) {
          _webViewReady = true;
          _pushSceneToJs();
        },
      ))
      ..loadFlutterAsset('assets/three/reservation.html');

    // Android: allow local file access for Three.js assets
    if (Platform.isAndroid) {
      final androidController =
          _webController.platform as AndroidWebViewController;
      AndroidWebViewController.enableDebugging(true);
      androidController.setMediaPlaybackRequiresUserGesture(false);
    }
  }

  void _onJsMessage(JavaScriptMessage message) {
    if (!mounted) return;
    final data = jsonDecode(message.message) as Map<String, dynamic>;
    if (data['type'] == 'TABLE_CLICKED') {
      _bloc.add(ReservationEvent.selectTable(
        tableId: data['tableId'] as String,
        label: data['label'] as String,
        capacity: data['capacity'] as int,
      ));
      _showTableBottomSheet();
    }
  }

  // ── Push data to JS ──────────────────────────────────────────────────

  void _pushSceneToJs() {
    final scene = _bloc.state.scene;
    if (scene == null || !_webViewReady) return;

    // Push panorama
    if (scene.panoramaUrl != null && scene.panoramaUrl!.isNotEmpty) {
      _loadPanoramaImage(scene.panoramaUrl!);
    }

    // Push table markers
    final tablesJson = jsonEncode(
      scene.tables
          .map((t) => {
                'tableId': t.tableId,
                'label': t.label,
                'yaw': t.yaw,
                'pitch': t.pitch,
                'capacity': t.capacity,
              })
          .toList(),
    );
    _webController.runJavaScript("window.setTables('${_escapeJs(tablesJson)}')");
  }

  void _pushStatusesToJs(List statuses) {
    if (!_webViewReady) return;
    final json = jsonEncode(
      statuses.map((s) => {'tableId': s.tableId, 'status': s.status}).toList(),
    );
    _webController.runJavaScript("window.updateStatuses('${_escapeJs(json)}')");
  }

  Future<void> _loadPanoramaImage(String url) async {
    try {
      // Resolve relative URLs using the API server base
      String fullUrl = url;
      if (url.startsWith('/')) {
        final apiBase = dotenv.get('API_BASE_URL', fallback: 'http://10.0.2.2:8081');
        final uri = Uri.parse(apiBase);
        final serverBase = '${uri.scheme}://${uri.host}:${uri.port}';
        fullUrl = '$serverBase$url';
      }

      // Load from network and convert to base64
      final bundle = await NetworkAssetBundle(Uri.parse(fullUrl)).load(fullUrl);
      final base64 = base64Encode(bundle.buffer.asUint8List());
      _webController.runJavaScript("window.setPanoramaBase64('$base64')");
    } catch (e) {
      debugPrint('[ReservationPage] Failed to load panorama: $e');
    }
  }

  String _escapeJs(String s) => s.replaceAll('\\', '\\\\').replaceAll("'", "\\'");

  // ── WebView widget (Hybrid Composition on Android for WebGL) ────────

  Widget _buildWebViewWidget() {
    final gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>{
      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
    };

    // Android: use Hybrid Composition so WebGL renders to its own surface
    // instead of going through Flutter's texture layer (SurfaceProducer),
    // which causes "unimplemented OpenGL ES API" conflicts.
    if (Platform.isAndroid) {
      return WebViewWidget.fromPlatformCreationParams(
        params: AndroidWebViewWidgetCreationParams(
          controller: _webController.platform as AndroidWebViewController,
          gestureRecognizers: gestureRecognizers,
          displayWithHybridComposition: true,
        ),
      );
    }

    return WebViewWidget(
      controller: _webController,
      gestureRecognizers: gestureRecognizers,
    );
  }

  // ── Bottom sheet ─────────────────────────────────────────────────────

  void _showTableBottomSheet() {
    if (_bottomSheetOpen) return;
    _bottomSheetOpen = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: _bloc,
        child: const TableBottomSheet(),
      ),
    ).whenComplete(() {
      _bottomSheetOpen = false;
    });
  }

  // ── Build ────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(S.of(context).tableReservation),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: BlocConsumer<ReservationBloc, ReservationState>(
          buildWhen: (prev, curr) =>
              prev.sceneLoading != curr.sceneLoading ||
              prev.sceneError != curr.sceneError ||
              prev.selectedTableId != curr.selectedTableId ||
              prev.selectedDate != curr.selectedDate,
          listener: (context, state) {
            // Push statuses to JS only when they actually change
            if (state.tableStatuses.isNotEmpty &&
                !identical(state.tableStatuses, _lastPushedStatuses)) {
              _lastPushedStatuses = state.tableStatuses;
              _pushStatusesToJs(state.tableStatuses);
            }
            // Push scene to JS once after it loads
            if (state.scene != null && _webViewReady && !_scenePushed) {
              _scenePushed = true;
              _pushSceneToJs();
            }
            // Navigate after successful reservation creation.
            // Deferred to post-frame to avoid !_debugLocked assertion
            // (the bottom sheet modal route may still be mid-transition).
            if (state.submitSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!context.mounted) return;
                Navigator.of(context).popUntil((route) => route.isFirst);
                MainShell.switchToTab(1);
                sl<MyReservationsBloc>().add(const MyReservationsEvent.refresh());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).reservationCreated),
                    backgroundColor: Colors.green,
                  ),
                );
              });
            }
            // Show conflict toast
            if (state.submitConflict) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).slotUnavailable),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.sceneLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if (state.sceneError != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).sceneLoadFailed,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _bloc.add(
                        ReservationEvent.loadScene(restaurantId: widget.restaurantId),
                      ),
                      child: Text(S.of(context).retry),
                    ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                // Panorama WebView
                _buildWebViewWidget(),

                // Date picker overlay (top)
                Positioned(
                  top: 8,
                  left: 16,
                  right: 16,
                  child: _DatePickerRow(
                    selectedDate: state.selectedDate,
                    onDateChanged: (date) =>
                        _bloc.add(ReservationEvent.changeDate(date: date)),
                  ),
                ),

                // Hint overlay (bottom)
                if (state.selectedTableId == null)
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          S.of(context).tapTableHint,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Date Picker Row ──────────────────────────────────────────────────────

class _DatePickerRow extends StatelessWidget {
  final String selectedDate;
  final ValueChanged<String> onDateChanged;

  const _DatePickerRow({required this.selectedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            _formatDate(selectedDate),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          TextButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.tryParse(selectedDate) ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 60)),
                locale: const Locale('cs', 'CZ'),
              );
              if (picked != null) {
                onDateChanged(picked.toIso8601String().substring(0, 10));
              }
            },
            child: Text(S.of(context).change, style: const TextStyle(color: Colors.tealAccent)),
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoDate) {
    final parts = isoDate.split('-');
    if (parts.length != 3) return isoDate;
    return '${parts[2]}.${parts[1]}.${parts[0]}';
  }
}
