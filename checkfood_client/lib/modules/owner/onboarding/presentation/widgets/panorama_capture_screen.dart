import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';
import 'angle_guidance_painter.dart';

class PanoramaCaptureScreen extends StatefulWidget {
  final String sessionId;

  const PanoramaCaptureScreen({super.key, required this.sessionId});

  @override
  State<PanoramaCaptureScreen> createState() => _PanoramaCaptureScreenState();
}

class _PanoramaCaptureScreenState extends State<PanoramaCaptureScreen> {
  CameraController? _cameraController;
  bool _cameraReady = false;
  bool _capturing = false;

  double _currentHeading = 0;
  final Set<int> _capturedAngles = {};
  StreamSubscription? _magnetometerSub;

  static const int totalAngles = 8;
  static const double angleStep = 360.0 / totalAngles;
  static const double alignmentThreshold = 15.0;

  // Low-pass filter state for compass
  double _filteredX = 0;
  double _filteredY = 0;
  static const double _alpha = 0.15;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _initCompass();
  }

  @override
  void dispose() {
    _magnetometerSub?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    final backCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _cameraController!.initialize();
      if (mounted) setState(() => _cameraReady = true);
    } catch (e) {
      debugPrint('[PanoramaCapture] Camera init failed: $e');
    }
  }

  void _initCompass() {
    _magnetometerSub = magnetometerEventStream().listen((event) {
      // Low-pass filter for smooth heading
      _filteredX = _filteredX * (1 - _alpha) + event.x * _alpha;
      _filteredY = _filteredY * (1 - _alpha) + event.y * _alpha;

      var heading = atan2(_filteredY, _filteredX) * 180 / pi;
      heading = (heading + 360) % 360;

      if (mounted) setState(() => _currentHeading = heading);
    });
  }

  int? get _activeTargetIndex {
    for (int i = 0; i < totalAngles; i++) {
      if (_capturedAngles.contains(i)) continue;
      final targetAngle = i * angleStep;
      final diff = _angleDiff(_currentHeading, targetAngle);
      if (diff <= alignmentThreshold) return i;
    }
    return null;
  }

  double _angleDiff(double a, double b) {
    final diff = (a - b).abs() % 360;
    return diff > 180 ? 360 - diff : diff;
  }

  Future<void> _capturePhoto() async {
    if (_capturing || _cameraController == null || !_cameraReady) return;

    final targetIdx = _activeTargetIndex;
    if (targetIdx == null) return;

    setState(() => _capturing = true);

    try {
      final XFile photo = await _cameraController!.takePicture();
      final Uint8List bytes = await photo.readAsBytes();
      final double actualAngle = _currentHeading;

      if (!mounted) return;

      context.read<OnboardingWizardBloc>().add(
        OnboardingWizardEvent.uploadPhoto(
          sessionId: widget.sessionId,
          angleIndex: targetIdx,
          actualAngle: actualAngle,
          fileBytes: bytes,
          filename: 'panorama_${targetIdx}_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      );

      _capturedAngles.add(targetIdx);
    } catch (e) {
      debugPrint('[PanoramaCapture] Capture failed: $e');
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  void _finalize() {
    context.read<OnboardingWizardBloc>().add(
      OnboardingWizardEvent.finalizePanorama(widget.sessionId),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Foceni panoramatu'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<OnboardingWizardBloc, OnboardingWizardState>(
        builder: (context, state) {
          if (!_cameraReady) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          final targetIdx = _activeTargetIndex;
          final canCapture = targetIdx != null && !_capturing && !state.loading;
          final canFinalize = _capturedAngles.length >= totalAngles && !state.loading;

          return Stack(
            fit: StackFit.expand,
            children: [
              // Camera preview
              CameraPreview(_cameraController!),

              // AR guidance overlay
              Center(
                child: SizedBox(
                  width: 280,
                  height: 280,
                  child: CustomPaint(
                    painter: AngleGuidancePainter(
                      currentHeading: _currentHeading,
                      capturedAngles: _capturedAngles,
                      totalAngles: totalAngles,
                      activeTargetIndex: targetIdx,
                    ),
                  ),
                ),
              ),

              // Progress indicator
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_capturedAngles.length}/$totalAngles fotek',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // Alignment hint
              if (targetIdx != null)
                Positioned(
                  bottom: 120,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Zamirite na ${(targetIdx * angleStep).toInt()}\u00B0 a fotkejte!',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

              if (targetIdx == null && _capturedAngles.length < totalAngles)
                Positioned(
                  bottom: 120,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Otocte se smerem k dalsimu bodu',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ),

              // Loading overlay
              if (state.loading)
                Container(
                  color: Colors.black45,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),

              // Bottom bar
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Capture button
                    if (!canFinalize)
                      GestureDetector(
                        onTap: canCapture ? _capturePhoto : null,
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: canCapture ? Colors.white : Colors.grey[700],
                            border: Border.all(
                              color: canCapture ? Colors.tealAccent : Colors.grey,
                              width: 4,
                            ),
                          ),
                          child: Icon(
                            Icons.camera,
                            size: 36,
                            color: canCapture ? Colors.black : Colors.grey[500],
                          ),
                        ),
                      ),

                    // Finalize button
                    if (canFinalize)
                      FilledButton.icon(
                        onPressed: _finalize,
                        icon: const Icon(Icons.check),
                        label: const Text('Finalizovat'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
