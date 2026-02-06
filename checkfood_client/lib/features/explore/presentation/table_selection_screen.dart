import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TableSelectionScreen extends StatefulWidget {
  const TableSelectionScreen({super.key});

  @override
  State<TableSelectionScreen> createState() => _TableSelectionScreenState();
}

class _TableSelectionScreenState extends State<TableSelectionScreen> {
  WebViewController? _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  Future<void> _initWebView() async {
    final html = await rootBundle.loadString('assets/three/index.html');

    final controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'TableChannel',
            onMessageReceived: (message) {
              final data = jsonDecode(message.message);
              debugPrint('Vybraný stůl: $data');
            },
          )
          ..loadHtmlString(html, baseUrl: 'https://checkfood.local/');

    setState(() {
      _controller = controller;
    });
  }

  // ===============================
  // JS BRIDGE
  // ===============================
  Future<void> _startEditor() async {
    await _controller?.runJavaScript('startLabelEditor()');
    setState(() => _isEditing = true);
  }

  Future<void> _finishEditor() async {
    await _controller?.runJavaScript('finishLabelEditor()');
    setState(() => _isEditing = false);
  }

  // ===============================
  // UI
  // ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Výběr stolu')),
      body:
          _controller == null
              ? const Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: _controller!),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isEditing)
            FloatingActionButton.extended(
              heroTag: 'start',
              onPressed: _startEditor,
              icon: const Icon(Icons.add),
              label: const Text('Přidat stůl'),
            ),
          if (_isEditing) ...[
            const SizedBox(height: 12),
            FloatingActionButton.extended(
              heroTag: 'finish',
              backgroundColor: Colors.red,
              onPressed: _finishEditor,
              icon: const Icon(Icons.check),
              label: const Text('Dokončit'),
            ),
          ],
        ],
      ),
    );
  }
}
