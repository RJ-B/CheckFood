import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';
import 'angle_guidance_painter.dart';

/// A single point on the capture sphere defined by horizontal (yaw) and
/// vertical (pitch) angles in degrees.
class SpherePoint {
  final int index;
  final double yaw;
  final double pitch;
  const SpherePoint(this.index, this.yaw, this.pitch);
}

/// 20 capture points arranged in three pitch rings: horizon (0°), upper (+30°),
/// and lower (−30°), spaced evenly around the full 360° yaw.
const List<SpherePoint> sphereGrid = [
  SpherePoint(0, 0, 0), SpherePoint(1, 45, 0), SpherePoint(2, 90, 0),
  SpherePoint(3, 135, 0), SpherePoint(4, 180, 0), SpherePoint(5, 225, 0),
  SpherePoint(6, 270, 0), SpherePoint(7, 315, 0),
  SpherePoint(8, 0, 30), SpherePoint(9, 60, 30), SpherePoint(10, 120, 30),
  SpherePoint(11, 180, 30), SpherePoint(12, 240, 30), SpherePoint(13, 300, 30),
  SpherePoint(14, 0, -30), SpherePoint(15, 60, -30), SpherePoint(16, 120, -30),
  SpherePoint(17, 180, -30), SpherePoint(18, 240, -30), SpherePoint(19, 300, -30),
];

const int _minPhotosToFinalize = 8;

/// Full-screen camera screen that guides the user to capture photos at each
/// sphere-grid point using compass and accelerometer for real-time alignment
/// feedback, then uploads each captured frame to the panorama session.
class PanoramaCaptureScreen extends StatefulWidget {
  final String sessionId;

  const PanoramaCaptureScreen({super.key, required this.sessionId});

  @override
  State<PanoramaCaptureScreen> createState() => _PanoramaCaptureScreenState();
}

/// State for [PanoramaCaptureScreen]: manages the camera controller, sensor
/// subscriptions, alignment detection, and auto-capture logic.
class _PanoramaCaptureScreenState extends State<PanoramaCaptureScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  bool _cameraReady = false;
  bool _capturing = false;

  double _currentYaw = 0;
  double _currentPitch = 0;
  StreamSubscription? _magnetometerSub;
  StreamSubscription? _accelerometerSub;

  double _filteredMagX = 0;
  double _filteredMagY = 0;
  double _filteredPitch = 0;
  static const double _alpha = 0.15;

  final Set<int> _capturedIndices = {};
  int? _alignedIndex;
  Timer? _stabilizationTimer;

  bool _showFlash = false;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.6).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _initCamera();
    _initCompass();
    _initPitchSensor();
  }

  @override
  void dispose() {
    _stabilizationTimer?.cancel();
    _magnetometerSub?.cancel();
    _accelerometerSub?.cancel();
    _cameraController?.dispose();
    _pulseController.dispose();
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
    } catch (_) {}
  }

  void _initCompass() {
    _magnetometerSub = magnetometerEventStream().listen((event) {
      _filteredMagX = _filteredMagX * (1 - _alpha) + event.x * _alpha;
      _filteredMagY = _filteredMagY * (1 - _alpha) + event.y * _alpha;

      var heading = atan2(_filteredMagY, _filteredMagX) * 180 / pi;
      heading = (heading + 360) % 360;

      if (mounted) {
        setState(() => _currentYaw = heading);
        _checkAlignment();
      }
    });
  }

  void _initPitchSensor() {
    _accelerometerSub = accelerometerEventStream().listen((event) {
      var pitch = atan2(-event.z, -event.y) * 180 / pi;
      _filteredPitch = _filteredPitch * (1 - _alpha) + pitch * _alpha;

      if (mounted) {
        setState(() => _currentPitch = _filteredPitch);
        _checkAlignment();
      }
    });
  }

  double _angleDiff(double a, double b) {
    final diff = (a - b).abs() % 360;
    return diff > 180 ? 360 - diff : diff;
  }

  void _checkAlignment() {
    int? nearestIndex;
    double nearestDist = double.infinity;

    for (final point in sphereGrid) {
      if (_capturedIndices.contains(point.index)) continue;
      final yawDiff = _angleDiff(_currentYaw, point.yaw);
      final pitchDiff = (_currentPitch - point.pitch).abs();
      if (yawDiff > 10 || pitchDiff > 10) continue;
      final dist = sqrt(yawDiff * yawDiff + pitchDiff * pitchDiff);
      if (dist < nearestDist) {
        nearestDist = dist;
        nearestIndex = point.index;
      }
    }

    if (nearestIndex != _alignedIndex) {
      _stabilizationTimer?.cancel();
      _alignedIndex = nearestIndex;
      if (nearestIndex != null) {
        _stabilizationTimer = Timer(const Duration(milliseconds: 500), () {
          if (mounted && _alignedIndex == nearestIndex) {
            _autoCapture(nearestIndex!);
          }
        });
      }
    }
  }

  Future<void> _autoCapture(int pointIndex) async {
    if (_capturing || _cameraController == null || !_cameraReady) return;

    setState(() => _capturing = true);

    try {
      HapticFeedback.mediumImpact();

      setState(() => _showFlash = true);
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) setState(() => _showFlash = false);
      });

      final XFile photo = await _cameraController!.takePicture();
      final Uint8List bytes = await photo.readAsBytes();

      if (!mounted) return;

      context.read<OnboardingWizardBloc>().add(
        OnboardingWizardEvent.uploadPhoto(
          sessionId: widget.sessionId,
          angleIndex: pointIndex,
          actualAngle: _currentYaw,
          actualPitch: _currentPitch,
          fileBytes: bytes,
          filename: 'panorama_${pointIndex}_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      );

      _capturedIndices.add(pointIndex);
      _alignedIndex = null;
    } catch (_) {
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  void _finalize() {
    context.read<OnboardingWizardBloc>().add(
      OnboardingWizardEvent.finalizePanorama(widget.sessionId),
    );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(S.of(context).arPhotoSphere),
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

          final canFinalize =
              _capturedIndices.length >= _minPhotosToFinalize && !state.loading;

          return Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(_cameraController!),

              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, _) => CustomPaint(
                  painter: SphereGuidancePainter(
                    currentYaw: _currentYaw,
                    currentPitch: _currentPitch,
                    capturedIndices: _capturedIndices,
                    sphereGrid: sphereGrid,
                    alignedIndex: _alignedIndex,
                    pulseScale: _pulseAnimation.value,
                  ),
                  size: Size.infinite,
                ),
              ),

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
                      S.of(context).capturedPhotos(_capturedIndices.length, sphereGrid.length),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: CustomPaint(
                      painter: _MiniMapPainter(
                        currentYaw: _currentYaw,
                        capturedIndices: _capturedIndices,
                        sphereGrid: sphereGrid,
                      ),
                    ),
                  ),
                ),
              ),

              if (_showFlash)
                Container(color: Colors.white.withValues(alpha: 0.6)),

              if (state.loading)
                Container(
                  color: Colors.black45,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),

              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (canFinalize)
                      FilledButton.icon(
                        onPressed: _finalize,
                        icon: const Icon(Icons.check),
                        label: Text(S.of(context).finalize),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                      ),
                    if (!canFinalize && _capturedIndices.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          S.of(context).minPhotosHint(_minPhotosToFinalize),
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
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

/// Custom painter that renders a bird's-eye mini-map of the capture sphere,
/// showing captured (filled) and pending (outline) points and the current
/// camera heading as a directional arrow.
class _MiniMapPainter extends CustomPainter {
  final double currentYaw;
  final Set<int> capturedIndices;
  final List<SpherePoint> sphereGrid;

  _MiniMapPainter({
    required this.currentYaw,
    required this.capturedIndices,
    required this.sphereGrid,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2 - 8;

    for (final point in sphereGrid) {
      double ringRadius;
      if (point.pitch > 0) {
        ringRadius = maxRadius * 0.35;
      } else if (point.pitch < 0) {
        ringRadius = maxRadius * 0.85;
      } else {
        ringRadius = maxRadius * 0.6;
      }

      final angle = point.yaw * pi / 180;
      final dx = center.dx + ringRadius * sin(angle);
      final dy = center.dy - ringRadius * cos(angle);

      final isCaptured = capturedIndices.contains(point.index);
      final paint = Paint()
        ..color = isCaptured ? AppColors.primary : Colors.white38
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dx, dy), isCaptured ? 4 : 3, paint);
    }

    final arrowAngle = currentYaw * pi / 180;
    final arrowEnd = Offset(
      center.dx + (maxRadius * 0.25) * sin(arrowAngle),
      center.dy - (maxRadius * 0.25) * cos(arrowAngle),
    );
    final arrowPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(center, arrowEnd, arrowPaint);

    canvas.drawCircle(arrowEnd, 3, Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant _MiniMapPainter oldDelegate) =>
      currentYaw != oldDelegate.currentYaw ||
      capturedIndices.length != oldDelegate.capturedIndices.length;
}
