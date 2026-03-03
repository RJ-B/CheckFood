import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Generates and caches cluster marker bitmaps for the map.
///
/// Icon size scales with the real cluster count so that denser areas
/// are visually distinguishable even when the label reads "99+".
class MapMarkerHelper {
  /// Cache keyed by "{size}_{label}" to avoid regenerating identical bitmaps.
  static final Map<String, BitmapDescriptor> _clusterCache = {};

  /// Returns the pixel size for a cluster icon based on the real point count.
  /// Small clusters (2-9) get baseSize, large ones scale up to baseSize*1.5.
  static int clusterIconSize(int count, {int baseSize = 90}) {
    if (count < 10) return baseSize;
    if (count < 50) return (baseSize * 1.15).round();
    if (count < 200) return (baseSize * 1.3).round();
    return (baseSize * 1.5).round(); // 200+
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
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final double radius = size / 2;

    // Background circle
    canvas.drawCircle(Offset(radius, radius), radius, paint);

    // White border ring
    final Paint strokePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
    canvas.drawCircle(Offset(radius, radius), radius - 1.5, strokePaint);

    // Label text
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: radius * 0.55,
        fontWeight: FontWeight.bold,
        color: Colors.white,
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
