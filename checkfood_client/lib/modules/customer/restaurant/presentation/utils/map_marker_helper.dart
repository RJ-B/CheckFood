import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/theme/colors.dart';

/// Generuje a cachuje markery na mapě ve stylu Qerko pro restaurace a clustery.
///
/// Rozvržení individuálního markeru (ukotvený dole):
///   [popisek s názvem]
///   [kruhový avatar (písmeno nebo ikona)]
///   [malý zelený pin ve tvaru kapky]
///
/// Marker clusteru:
///   Smaragdově zelený kruh s bílým popiskem počtu +
///   malý oranžový tečkový indikátor vpravo nahoře.
class MapMarkerHelper {
  static final Map<String, BitmapDescriptor> _clusterCache = {};
  static final Map<String, BitmapDescriptor> _pinCache = {};

  static const double _minDiameter = 44;
  static const double _maxDiameter = 80;
  static const double _base = 40;
  static const double _k = 22;
  static const double _zoomScale = 0.6;

  static const double _circleDiameter = 48.0;
  static const double _circleRadius = _circleDiameter / 2;
  static const double _borderWidth = 3.0;
  static const double _selectedCircleDiameter = 58.0;
  static const double _selectedCircleRadius = _selectedCircleDiameter / 2;
  static const double _selectedBorderWidth = 3.5;

  static const double _pinWidth = 10.0;
  static const double _pinHeight = 8.0;

  static const double _labelFontSize = 10.0;
  static const double _labelPadH = 6.0;
  static const double _labelPadV = 3.0;
  static const double _labelRadius = 4.0;
  static const double _labelMaxWidth = 80.0;

  static const double _scale = 2.5;

  /// Vrátí průměr ikony clusteru v pixelech.
  static int clusterIconSize(int count, {int zoom = 14}) {
    final logPart = count > 1 ? math.log(count) / math.ln10 : 0.0;
    final raw = _base + _k * logPart - _zoomScale * zoom;
    return raw.clamp(_minDiameter, _maxDiameter).round();
  }

  /// Vytvoří bitmapu clusteru — smaragdový kruh + bílý počet + oranžová tečka.
  static Future<BitmapDescriptor> getClusterBitmap(
    int size, {
    required String text,
  }) async {
    final cacheKey = 'cluster_${size}_$text';
    if (_clusterCache.containsKey(cacheKey)) {
      return _clusterCache[cacheKey]!;
    }

    const double dotRadius = 5.0;
    final double canvasSize = size + dotRadius * 2;
    final double cx = canvasSize / 2;
    final double cy = canvasSize / 2;
    final double r = size / 2;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()..color = AppColors.primary,
    );

    final borderWidth = (size * 0.06).clamp(1.5, 3.0);
    canvas.drawCircle(
      Offset(cx, cy),
      r - borderWidth / 2,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth,
    );

    final fontSize = (r * 0.55).clamp(8.0, 16.0);
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
      Offset(cx - textPainter.width / 2, cy - textPainter.height / 2),
    );

    final double dotCx = cx + r * math.cos(-math.pi / 4);
    final double dotCy = cy + r * math.sin(-math.pi / 4);
    canvas.drawCircle(
      Offset(dotCx, dotCy),
      dotRadius,
      Paint()..color = const Color(0xFFF59E0B), // Amber-400
    );
    canvas.drawCircle(
      Offset(dotCx, dotCy),
      dotRadius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    final imgSize = canvasSize.round();
    final img = await recorder.endRecording().toImage(imgSize, imgSize);
    final ByteData? data = await img.toByteData(format: ui.ImageByteFormat.png);

    if (data == null) return BitmapDescriptor.defaultMarker;

    final bitmap = BitmapDescriptor.bytes(data.buffer.asUint8List());
    _clusterCache[cacheKey] = bitmap;
    return bitmap;
  }

  /// Vytvoří marker restaurace ve stylu Qerko:
  ///   • Kruhový avatar s bílým okrajem (písmeno nebo ikona vidličky)
  ///   • Malý zelený pin ve tvaru kapky pod kruhem
  ///   • Popisek s názvem restaurace dole
  ///
  /// [id] — slouží k odlišení klíče cache.
  /// [name] — zobrazen jako popisek a použit pro písmeno avataru.
  /// [isSelected] — vybraný stav je větší s vrženým stínem.
  static Future<BitmapDescriptor> getRestaurantBitmap({
    required String id,
    String? name,
    String? logoUrl,
    bool isSelected = false,
  }) async {
    final cacheKey = 'rest_${id}_$isSelected';
    if (_pinCache.containsKey(cacheKey)) {
      return _pinCache[cacheKey]!;
    }

    final double circleD =
        isSelected ? _selectedCircleDiameter : _circleDiameter;
    final double circleR =
        isSelected ? _selectedCircleRadius : _circleRadius;
    final double border = isSelected ? _selectedBorderWidth : _borderWidth;

    final String displayName = name ?? '';
    final bool hasName = displayName.isNotEmpty;

    final labelPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '…',
      textAlign: TextAlign.center,
      text: TextSpan(
        text: displayName,
        style: const TextStyle(
          fontSize: _labelFontSize,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
    if (hasName) {
      labelPainter.layout(maxWidth: _labelMaxWidth);
    }

    final double labelW =
        hasName ? labelPainter.width + _labelPadH * 2 : 0;
    final double labelH =
        hasName ? labelPainter.height + _labelPadV * 2 : 0;
    const double labelSpacing = 3.0; // gap between pin tip and label

    const double shadowBlur = 6.0;
    final double shadowPad = isSelected ? shadowBlur : 0;

    final double totalW =
        math.max(circleD + shadowPad * 2, labelW) + shadowPad * 2;
    final double totalH =
        shadowPad + circleD + _pinHeight + (hasName ? labelSpacing + labelH : 0) + shadowPad;

    final double sw = totalW * _scale;
    final double sh = totalH * _scale;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Rect.fromLTWH(0, 0, sw, sh));
    canvas.scale(_scale);

    final double cx = totalW / 2;          // horizontal centre
    final double circleTop = shadowPad;    // top of the circle
    final double circleCy = circleTop + circleR; // vertical centre of circle

    if (isSelected) {
      canvas.drawCircle(
        Offset(cx, circleCy + 2),
        circleR,
        Paint()
          ..color = Colors.black.withValues(alpha: 0.25)
          ..maskFilter =
              const MaskFilter.blur(BlurStyle.normal, shadowBlur),
      );
    }

    final bool useLetter = hasName;
    final Color circleFill =
        useLetter ? AppColors.brandDark : AppColors.primary;

    canvas.drawCircle(
      Offset(cx, circleCy),
      circleR,
      Paint()..color = circleFill,
    );

    canvas.drawCircle(
      Offset(cx, circleCy),
      circleR - border / 2,
      Paint()
        ..color = isSelected ? AppColors.primary : Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = border,
    );

    if (useLetter) {
      _drawLetter(
        canvas,
        letter: displayName[0].toUpperCase(),
        cx: cx,
        cy: circleCy,
        fontSize: circleR * 0.85,
      );
    } else {
      _drawIcon(
        canvas,
        iconCode: Icons.restaurant.codePoint,
        cx: cx,
        cy: circleCy,
        size: circleR * 0.95,
      );
    }

    final double pinTop = circleTop + circleD;
    final double pinCx = cx;
    _drawPin(canvas, cx: pinCx, top: pinTop);

    if (hasName) {
      final double labelTop = pinTop + _pinHeight + labelSpacing;
      final double labelLeft = cx - labelW / 2;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(labelLeft, labelTop, labelW, labelH),
          const Radius.circular(_labelRadius),
        ),
        Paint()..color = AppColors.brandDark.withValues(alpha: 0.85),
      );

      labelPainter.paint(
        canvas,
        Offset(labelLeft + _labelPadH, labelTop + _labelPadV),
      );
    }

    final img = await recorder
        .endRecording()
        .toImage(sw.round(), sh.round());
    final ByteData? data =
        await img.toByteData(format: ui.ImageByteFormat.png);

    if (data == null) return BitmapDescriptor.defaultMarker;

    final bitmap = BitmapDescriptor.bytes(
      data.buffer.asUint8List(),
      imagePixelRatio: _scale,
    );
    _pinCache[cacheKey] = bitmap;
    return bitmap;
  }

  /// Nakreslí malý pin ve tvaru kapky směřující dolů pod kruh.
  static void _drawPin(Canvas canvas, {required double cx, required double top}) {
    const double halfW = _pinWidth / 2;
    final path = Path()
      ..moveTo(cx - halfW, top)
      ..quadraticBezierTo(cx - halfW * 0.4, top + _pinHeight * 0.6, cx, top + _pinHeight)
      ..quadraticBezierTo(cx + halfW * 0.4, top + _pinHeight * 0.6, cx + halfW, top)
      ..close();

    canvas.drawPath(path, Paint()..color = AppColors.primary);
  }

  /// Nakreslí jeden znak vystředěný v kruhu pomocí ui.Paragraph.
  static void _drawLetter(
    Canvas canvas, {
    required String letter,
    required double cx,
    required double cy,
    required double fontSize,
  }) {
    final pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: fontSize,
      ),
    )
      ..pushStyle(
        ui.TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: ui.FontWeight.bold,
        ),
      )
      ..addText(letter);

    final paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: fontSize * 2));

    canvas.drawParagraph(
      paragraph,
      Offset(cx - paragraph.width / 2, cy - paragraph.height / 2),
    );
  }

  /// Nakreslí glyf Material ikony vystředěný v kruhu pomocí ui.Paragraph.
  static void _drawIcon(
    Canvas canvas, {
    required int iconCode,
    required double cx,
    required double cy,
    required double size,
  }) {
    final pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: size,
      ),
    )
      ..pushStyle(
        ui.TextStyle(
          color: Colors.white,
          fontSize: size,
          fontFamily: 'MaterialIcons',
        ),
      )
      ..addText(String.fromCharCode(iconCode));

    final paragraph = pb.build()
      ..layout(ui.ParagraphConstraints(width: size + 4));

    canvas.drawParagraph(
      paragraph,
      Offset(cx - paragraph.width / 2, cy - paragraph.height / 2),
    );
  }

  /// Předgeneruje dvě generické varianty pinu (bez id, bez jména) pro rychlé první vykreslení.
  static Future<void> preGeneratePins() async {
    await Future.wait([
      getRestaurantBitmap(id: '_default', isSelected: false),
      getRestaurantBitmap(id: '_default', isSelected: true),
    ]);
  }

  static void clearCache() {
    _clusterCache.clear();
    _pinCache.clear();
  }
}
