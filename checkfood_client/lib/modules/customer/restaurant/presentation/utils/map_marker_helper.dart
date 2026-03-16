import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/theme/colors.dart';

/// Generates and caches cluster and restaurant pin bitmaps for the map.
///
/// Cluster diameter formula:
///   diameterPx = clamp(36, 68, base + k * log10(count) - zoomScale * zoom)
/// Produces icons between 36px and 68px diameter (18-34px radius).
class MapMarkerHelper {
  static final Map<String, BitmapDescriptor> _clusterCache = {};
  static final Map<String, BitmapDescriptor> _pinCache = {};

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

  /// Creates a cluster bitmap (emerald circle with label).
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
    final Paint paint = Paint()..color = AppColors.primary; // Emerald #10B981

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

  /// Creates a branded teardrop restaurant pin.
  /// [isSelected] — true = emerald fill + larger size, false = dark teal fill.
  /// Uses caching by key `rest_${isSelected}`.
  static Future<BitmapDescriptor> getRestaurantBitmap({
    bool isSelected = false,
  }) async {
    final cacheKey = 'rest_$isSelected';
    if (_pinCache.containsKey(cacheKey)) {
      return _pinCache[cacheKey]!;
    }

    // Device pixel ratio scaling — use 2.0 as base for crisp rendering
    const double scale = 2.0;
    final double w = (isSelected ? 56 : 48) * scale;
    final double h = (isSelected ? 72 : 64) * scale;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, w, h));

    final Color fillColor =
        isSelected ? AppColors.primary : AppColors.brandDark;

    // Shadow for selected
    if (isSelected) {
      final Paint shadowPaint =
          Paint()
            ..color = Colors.black.withValues(alpha: 0.3)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      _drawTeardrop(canvas, w, h, shadowPaint, offsetY: 3);
    }

    // Main teardrop body
    final Paint bodyPaint = Paint()..color = fillColor;
    _drawTeardrop(canvas, w, h, bodyPaint);

    // White border
    final Paint borderPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5 * scale;
    _drawTeardrop(canvas, w, h, borderPaint);

    // Restaurant icon (fork+knife) in center of circular head
    final double iconSize = (isSelected ? 22 : 18) * scale;
    final double headCenterX = w / 2;
    final double headRadius = w * 0.42;
    final double headCenterY = headRadius;

    final ui.ParagraphBuilder pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: iconSize,
      ),
    )
      ..pushStyle(
        ui.TextStyle(
          color: Colors.white,
          fontSize: iconSize,
          fontFamily: 'MaterialIcons',
        ),
      )
      ..addText(String.fromCharCode(Icons.restaurant.codePoint));

    final ui.Paragraph paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: iconSize + 4));

    canvas.drawParagraph(
      paragraph,
      Offset(
        headCenterX - paragraph.width / 2,
        headCenterY - paragraph.height / 2,
      ),
    );

    final img = await recorder
        .endRecording()
        .toImage(w.round(), h.round());
    final ByteData? data = await img.toByteData(
      format: ui.ImageByteFormat.png,
    );

    if (data == null) {
      return BitmapDescriptor.defaultMarker;
    }

    final BitmapDescriptor bitmap = BitmapDescriptor.bytes(
      data.buffer.asUint8List(),
      imagePixelRatio: scale,
    );

    _pinCache[cacheKey] = bitmap;
    return bitmap;
  }

  /// Draws a teardrop path (circle on top, pointed bottom).
  static void _drawTeardrop(
    Canvas canvas,
    double w,
    double h,
    Paint paint, {
    double offsetY = 0,
  }) {
    final double r = w * 0.42; // radius of circular head
    final double cx = w / 2;
    final double cy = r + offsetY;

    final Path path = Path();

    // Circle arc top + sides
    path.addArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      math.pi * 0.75,  // start ~225°
      math.pi * 1.5,   // sweep 270° (leaving gap at bottom for point)
    );

    // Lines converging to point at bottom
    path.lineTo(cx, h - offsetY);
    path.close();

    canvas.drawPath(path, paint);
  }

  /// Pre-generate all 2 pin variants (selected/unselected) for fast first render.
  static Future<void> preGeneratePins() async {
    await Future.wait([
      getRestaurantBitmap(isSelected: false),
      getRestaurantBitmap(isSelected: true),
    ]);
  }

  static void clearCache() {
    _clusterCache.clear();
    _pinCache.clear();
  }
}
