import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Generates and caches cluster marker bitmaps for the map.
///
/// Cluster diameter formula:
///   diameterPx = clamp(36, 68, base + k * log10(count) - zoomScale * zoom)
/// Produces icons between 36px and 68px diameter (18-34px radius).
class MapMarkerHelper {
  static final Map<String, BitmapDescriptor> _clusterCache = {};

  static const double _minDiameter = 36;
  static const double _maxDiameter = 68;
  static const double _base = 30;
  static const double _k = 20;
  static const double _zoomScale = 0.8;

  /// Returns the pixel diameter for a cluster icon.
  /// [count] — number of restaurants in the cluster.
  /// [zoom] — current map zoom level.
  static int clusterIconSize(int count, {int zoom = 14}) {
    final logPart = count > 1 ? math.log(count) / math.ln10 : 0.0;
    final raw = _base + _k * logPart - _zoomScale * zoom;
    return raw.clamp(_minDiameter, _maxDiameter).round();
  }

  /// Creates a cluster bitmap (green circle with label).
  /// Uses caching by size+text to avoid flickering and redundant rasterization.
  static Future<BitmapDescriptor> getClusterBitmap(
    int size, {
    required String text,
  }) async {
    final cacheKey = '${size}_$text';
    if (_clusterCache.containsKey(cacheKey)) {
      return _clusterCache[cacheKey]!;
    }

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = const Color(0xFF00C853);

    final double radius = size / 2;

    // Background circle
    canvas.drawCircle(Offset(radius, radius), radius, paint);

    // White border ring — scales proportionally with icon size
    final borderWidth = (size * 0.06).clamp(1.5, 3.0);
    final Paint strokePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;
    canvas.drawCircle(
      Offset(radius, radius),
      radius - borderWidth / 2,
      strokePaint,
    );

    // Label text — font size proportional to diameter
    final fontSize = (radius * 0.55).clamp(8.0, 16.0);
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(radius - textPainter.width / 2, radius - textPainter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final ByteData? data = await img.toByteData(format: ui.ImageByteFormat.png);

    if (data == null) {
      return BitmapDescriptor.defaultMarker;
    }

    final BitmapDescriptor bitmap = BitmapDescriptor.bytes(
      data.buffer.asUint8List(),
    );

    _clusterCache[cacheKey] = bitmap;
    return bitmap;
  }

  static void clearCache() {
    _clusterCache.clear();
  }
}
