import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';

/// Celoobrazkový QR kód skener, který načte kód pozvánky ke stolu a spustí
/// [OrdersEvent.joinSession] na nadřazeném [OrdersBloc].
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _processed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_processed) return;
    final barcode = capture.barcodes.firstOrNull;
    final raw = barcode?.rawValue;
    if (raw == null || raw.isEmpty) return;

    final inviteCode = _extractInviteCode(raw);
    if (inviteCode.isEmpty) return;

    setState(() => _processed = true);
    _controller.stop();

    context.read<OrdersBloc>().add(OrdersEvent.joinSession(inviteCode: inviteCode));
  }

  /// Extrahuje kód pozvánky z [raw], který může být holý kód nebo celá URL adresa.
  String _extractInviteCode(String raw) {
    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      final uri = Uri.tryParse(raw);
      if (uri != null) {
        final segments = uri.pathSegments;
        return segments.isNotEmpty ? segments.last : '';
      }
    }
    return raw.trim();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersBloc, OrdersState>(
      listenWhen: (prev, curr) =>
          prev.sessionJoining != curr.sessionJoining ||
          prev.sessionJoinError != curr.sessionJoinError ||
          prev.session != curr.session,
      listener: (context, state) {
        if (!state.sessionJoining && state.sessionJoinError == null && state.session != null && _processed) {
          Navigator.of(context).pop(true);
        } else if (state.sessionJoinError != null && _processed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.sessionJoinError!),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          setState(() => _processed = false);
          _controller.start();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Naskenovat QR kód stolu'),
          actions: [
            IconButton(
              icon: const Icon(Icons.flash_on),
              onPressed: () => _controller.toggleTorch(),
              tooltip: 'Baterka',
            ),
            IconButton(
              icon: const Icon(Icons.flip_camera_ios),
              onPressed: () => _controller.switchCamera(),
              tooltip: 'Přepnout kameru',
            ),
          ],
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          buildWhen: (prev, curr) => prev.sessionJoining != curr.sessionJoining,
          builder: (context, state) {
            if (state.sessionJoining) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Připojuji ke stolu...'),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                MobileScanner(
                  controller: _controller,
                  onDetect: _onDetect,
                ),
                Center(
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 48,
                  left: 0,
                  right: 0,
                  child: Text(
                    'Nasměrujte kameru na QR kód stolu',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          shadows: const [
                            Shadow(color: Colors.black, blurRadius: 4),
                          ],
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
