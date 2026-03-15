import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../l10n/generated/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

/// Data class for a table marker in the editor.
class EditorTable {
  final String id;
  String label;
  int capacity;
  double yaw;
  double pitch;
  bool isNew;

  EditorTable({
    required this.id,
    required this.label,
    required this.capacity,
    required this.yaw,
    required this.pitch,
    this.isNew = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'capacity': capacity,
        'yaw': yaw,
        'pitch': pitch,
      };
}

class PanoramaEditorScreen extends StatefulWidget {
  final String panoramaUrl;
  final List<EditorTable> existingTables;
  final Future<void> Function(List<EditorTable> tables) onSave;

  const PanoramaEditorScreen({
    super.key,
    required this.panoramaUrl,
    required this.existingTables,
    required this.onSave,
  });

  @override
  State<PanoramaEditorScreen> createState() => _PanoramaEditorScreenState();
}

class _PanoramaEditorScreenState extends State<PanoramaEditorScreen> {
  late final WebViewController _webController;
  bool _webViewReady = false;
  bool _dataPushed = false;
  bool _saving = false;
  final List<EditorTable> _tables = [];

  @override
  void initState() {
    super.initState();
    _tables.addAll(widget.existingTables);
    _initWebView();
  }

  void _initWebView() {
    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'EditorChannel',
        onMessageReceived: _onJsMessage,
      )
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) {
          _webViewReady = true;
          _pushDataToJs();
        },
      ))
      ..loadFlutterAsset('assets/three/index.html');

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

    switch (data['type']) {
      case 'LABEL_ADDED':
        _handleLabelAdded(data);
        break;
      case 'LABEL_CLICKED':
        _handleLabelClicked(data);
        break;
      case 'TABLES_EXPORTED':
        _handleTablesExported(data);
        break;
    }
  }

  void _handleLabelAdded(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final yaw = (data['yaw'] as num).toDouble();
    final pitch = (data['pitch'] as num).toDouble();

    // Show dialog to set label and capacity
    _showEditDialog(
      title: S.of(context).newTable,
      initialLabel: S.of(context).table,
      initialCapacity: 4,
      onConfirm: (label, capacity) {
        final table = EditorTable(
          id: id,
          label: label,
          capacity: capacity,
          yaw: yaw,
          pitch: pitch,
          isNew: true,
        );
        _tables.add(table);
        _webController.runJavaScript(
          "window.updateLabel('${_escapeJs(jsonEncode({'id': id, 'label': label, 'capacity': capacity}))}')",
        );
      },
      onCancel: () {
        _webController.runJavaScript("window.removeLabel('$id')");
      },
    );
  }

  void _handleLabelClicked(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final label = data['label'] as String;
    final capacity = (data['capacity'] as num).toInt();

    _showEditDialog(
      title: S.of(context).editTable,
      initialLabel: label,
      initialCapacity: capacity,
      showDelete: true,
      onConfirm: (newLabel, newCapacity) {
        final idx = _tables.indexWhere((t) => t.id == id);
        if (idx != -1) {
          _tables[idx].label = newLabel;
          _tables[idx].capacity = newCapacity;
        }
        _webController.runJavaScript(
          "window.updateLabel('${_escapeJs(jsonEncode({'id': id, 'label': newLabel, 'capacity': newCapacity}))}')",
        );
      },
      onDelete: () {
        _tables.removeWhere((t) => t.id == id);
        _webController.runJavaScript("window.removeLabel('$id')");
      },
    );
  }

  void _handleTablesExported(Map<String, dynamic> data) async {
    final exportedTables = (data['tables'] as List).map((t) {
      return EditorTable(
        id: t['id'] as String,
        label: t['label'] as String,
        capacity: (t['capacity'] as num).toInt(),
        yaw: (t['yaw'] as num).toDouble(),
        pitch: (t['pitch'] as num).toDouble(),
        isNew: _tables.firstWhere(
              (et) => et.id == t['id'],
              orElse: () => EditorTable(id: '', label: '', capacity: 0, yaw: 0, pitch: 0, isNew: true),
            ).isNew,
      );
    }).toList();

    setState(() => _saving = true);
    try {
      await widget.onSave(exportedTables);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).editorSaved),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).editorSaveError(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  // Push panorama + tables to JS
  void _pushDataToJs() {
    if (!_webViewReady || _dataPushed) return;
    _dataPushed = true;

    _loadPanoramaImage(widget.panoramaUrl);

    if (_tables.isNotEmpty) {
      final tablesJson = jsonEncode(_tables.map((t) => t.toJson()).toList());
      _webController.runJavaScript("window.loadTables('${_escapeJs(tablesJson)}')");
    }
  }

  Future<void> _loadPanoramaImage(String url) async {
    try {
      String fullUrl = url;
      if (url.startsWith('/')) {
        final apiBase = dotenv.get('API_BASE_URL', fallback: 'http://10.0.2.2:8081');
        final uri = Uri.parse(apiBase);
        final serverBase = '${uri.scheme}://${uri.host}:${uri.port}';
        fullUrl = '$serverBase$url';
      }

      final bundle = await NetworkAssetBundle(Uri.parse(fullUrl)).load(fullUrl);
      final base64 = base64Encode(bundle.buffer.asUint8List());
      _webController.runJavaScript("window.setPanoramaBase64('$base64')");
    } catch (e) {
      debugPrint('[PanoramaEditor] Failed to load panorama: $e');
    }
  }

  String _escapeJs(String s) => s.replaceAll('\\', '\\\\').replaceAll("'", "\\'");

  Widget _buildWebViewWidget() {
    final gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>{
      Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
    };

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

  void _showEditDialog({
    required String title,
    required String initialLabel,
    required int initialCapacity,
    required void Function(String label, int capacity) onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onDelete,
    bool showDelete = false,
  }) {
    final labelController = TextEditingController(text: initialLabel);
    final capacityController = TextEditingController(text: initialCapacity.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: InputDecoration(labelText: S.of(context).tableName),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: capacityController,
              decoration: InputDecoration(labelText: S.of(context).capacity),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          if (showDelete)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                onDelete?.call();
              },
              child: Text(S.of(context).delete, style: const TextStyle(color: Colors.red)),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onCancel?.call();
            },
            child: Text(S.of(context).cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm(
                labelController.text,
                int.tryParse(capacityController.text) ?? initialCapacity,
              );
            },
            child: Text(S.of(context).confirm),
          ),
        ],
      ),
    );
  }

  void _onSavePressed() {
    _webController.runJavaScript('window.exportTables()');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(S.of(context).tableEditor),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: S.of(context).addTableTooltip,
            onPressed: () => _webController.runJavaScript('window.enterEditMode()'),
          ),
          IconButton(
            icon: const Icon(Icons.done),
            tooltip: S.of(context).finishAddingTooltip,
            onPressed: () => _webController.runJavaScript('window.exitEditMode()'),
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildWebViewWidget(),
          if (_saving)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saving ? null : _onSavePressed,
        icon: const Icon(Icons.save),
        label: Text(S.of(context).save),
        backgroundColor: Colors.green,
      ),
    );
  }
}
