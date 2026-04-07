import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/restaurant_marker.dart';

/// Describes a single marker's animated transition between two screen positions.
class MarkerTransition {
  final Offset from;
  final Offset to;
  final RestaurantMarker marker;
  final bool isCluster;
  final double size;
  final String label;

  const MarkerTransition({
    required this.from,
    required this.to,
    required this.marker,
    required this.isCluster,
    required this.size,
    required this.label,
  });

  Offset positionAt(double t) => Offset.lerp(from, to, t)!;

  double scaleAt(double t, bool isExpanding) {
    return isExpanding ? 0.3 + 0.7 * t : 1.0 - 0.7 * t;
  }
}

/// Controls animated transitions between cluster and individual marker states.
///
/// ONLY animates cluster↔individual transitions, NOT cluster↔cluster.
class MarkerAnimationManager {
  final TickerProvider vsync;
  final VoidCallback onAnimationComplete;
  final VoidCallback onFrameUpdate;

  late final AnimationController _controller;

  List<MarkerTransition> _transitions = [];
  bool _isExpanding = true;

  List<RestaurantMarker> _previousMarkers = [];
  double _previousZoom = 0;

  bool get isAnimating => _controller.isAnimating;
  double get progress => _controller.value;
  List<MarkerTransition> get transitions => _transitions;
  bool get isExpanding => _isExpanding;

  MarkerAnimationManager({
    required this.vsync,
    required this.onAnimationComplete,
    required this.onFrameUpdate,
  }) {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: vsync,
    )..addListener(onFrameUpdate);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _transitions = [];
        onAnimationComplete();
      }
    });
  }

  void dispose() {
    _controller.dispose();
  }

  void cancel() {
    if (_controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
    _transitions = [];
  }

  /// Animate transition. Returns `true` if animation started.
  ///
  /// Only animates when:
  /// - Zoom changed significantly (≥ 0.3)
  /// - There are cluster↔individual transitions (NOT cluster↔cluster)
  Future<bool> transitionTo({
    required List<RestaurantMarker> newMarkers,
    required double newZoom,
    required GoogleMapController mapController,
  }) async {
    cancel();

    final oldMarkers = _previousMarkers;
    final oldZoom = _previousZoom;

    _previousMarkers = List.of(newMarkers);
    _previousZoom = newZoom;

    if (oldMarkers.isEmpty) return false;

    final zoomDelta = (newZoom - oldZoom).abs();
    if (zoomDelta < 0.3) return false;

    _isExpanding = newZoom > oldZoom;

    final oldClusters = oldMarkers.where((m) => m.isCluster).toList();
    final oldIndividuals = oldMarkers.where((m) => !m.isCluster).toList();
    final newClusters = newMarkers.where((m) => m.isCluster).toList();
    final newIndividuals = newMarkers.where((m) => !m.isCluster).toList();

    if (_isExpanding && oldClusters.isEmpty) return false;
    if (_isExpanding && newIndividuals.isEmpty) return false;
    if (!_isExpanding && oldIndividuals.isEmpty) return false;
    if (!_isExpanding && newClusters.isEmpty) return false;

    final List<_RawTransition> rawTransitions = [];

    if (_isExpanding) {
      for (final newMarker in newIndividuals) {
        final wasAlreadyVisible = oldIndividuals.any((old) =>
            old.id != null && old.id == newMarker.id);
        if (wasAlreadyVisible) continue;

        final nearestCluster = _findNearest(newMarker, oldClusters);
        if (nearestCluster != null) {
          rawTransitions.add(_RawTransition(
            fromLatLng: LatLng(nearestCluster.latitude, nearestCluster.longitude),
            toLatLng: LatLng(newMarker.latitude, newMarker.longitude),
            marker: newMarker,
            isCluster: false,
          ));
        }
      }
    } else {
      for (final oldMarker in oldIndividuals) {
        final stillVisible = newIndividuals.any((n) =>
            n.id != null && n.id == oldMarker.id);
        if (stillVisible) continue;

        final nearestCluster = _findNearest(oldMarker, newClusters);
        if (nearestCluster != null) {
          rawTransitions.add(_RawTransition(
            fromLatLng: LatLng(oldMarker.latitude, oldMarker.longitude),
            toLatLng: LatLng(nearestCluster.latitude, nearestCluster.longitude),
            marker: oldMarker,
            isCluster: false,
          ));
        }
      }
    }

    dev.log(
      'animation: expanding=$_isExpanding zoomDelta=${zoomDelta.toStringAsFixed(2)} '
      'transitions=${rawTransitions.length} '
      'oldClusters=${oldClusters.length} oldIndiv=${oldIndividuals.length} '
      'newClusters=${newClusters.length} newIndiv=${newIndividuals.length}',
      name: 'CheckFood.Animation',
    );

    if (rawTransitions.isEmpty) return false;

    try {
      final fromCoords = await Future.wait(
        rawTransitions.map((t) => mapController.getScreenCoordinate(t.fromLatLng)),
      );
      final toCoords = await Future.wait(
        rawTransitions.map((t) => mapController.getScreenCoordinate(t.toLatLng)),
      );

      _transitions = [];
      for (int i = 0; i < rawTransitions.length; i++) {
        final raw = rawTransitions[i];
        final from = Offset(fromCoords[i].x.toDouble(), fromCoords[i].y.toDouble());
        final to = Offset(toCoords[i].x.toDouble(), toCoords[i].y.toDouble());

        if ((from - to).distance < 3) continue;

        final marker = raw.marker;
        _transitions.add(MarkerTransition(
          from: from,
          to: to,
          marker: marker,
          isCluster: raw.isCluster,
          size: 40.0,
          label: marker.name?.isNotEmpty == true
              ? marker.name![0].toUpperCase()
              : '?',
        ));
      }

      dev.log(
        'animation: starting with ${_transitions.length} visible transitions',
        name: 'CheckFood.Animation',
      );

      if (_transitions.isEmpty) return false;

      _controller.forward(from: 0.0);
      return true;
    } catch (e) {
      dev.log('animation: getScreenCoordinate failed: $e',
          name: 'CheckFood.Animation');
      return false;
    }
  }

  RestaurantMarker? _findNearest(
    RestaurantMarker target,
    List<RestaurantMarker> candidates,
  ) {
    if (candidates.isEmpty) return null;
    RestaurantMarker? best;
    double bestDist = double.infinity;
    for (final c in candidates) {
      final dlat = target.latitude - c.latitude;
      final dlng = target.longitude - c.longitude;
      final dist = dlat * dlat + dlng * dlng;
      if (dist < bestDist) {
        bestDist = dist;
        best = c;
      }
    }
    return best;
  }
}

/// Internal data class pairing a [RestaurantMarker] with its animation source
/// and destination coordinates for one cluster expansion or collapse step.
class _RawTransition {
  final LatLng fromLatLng;
  final LatLng toLatLng;
  final RestaurantMarker marker;
  final bool isCluster;

  const _RawTransition({
    required this.fromLatLng,
    required this.toLatLng,
    required this.marker,
    required this.isCluster,
  });
}
