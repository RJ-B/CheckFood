import 'package:flutter/material.dart';

class AppColors {
  // Brand — derived from splash screen
  static const primary = Color(0xFF10B981);       // Emerald green — main accent
  static const primaryLight = Color(0xFFD1FAE5);   // Emerald 100 — light accent bg
  static const primaryDark = Color(0xFF059669);     // Emerald 700 — text on white (WCAG AA)

  // Brand dark teal — from splash gradient
  static const brandDark = Color(0xFF1A3C40);       // Dark teal for branded elements
  static const brandGradientStart = Color(0xFF0F2027); // Splash gradient start
  static const brandGradientMid = Color(0xFF203A43);   // Splash gradient middle
  static const brandGradientEnd = Color(0xFF2C5364);   // Splash gradient end

  // Backgrounds & surfaces — UNCHANGED (light theme)
  static const background = Color(0xFFFAFAFA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceElevated = Color(0xFFFFFFFF);

  // Text — UNCHANGED
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B7280);
  static const textMuted = Color(0xFF9CA3AF);

  // Borders — UNCHANGED
  static const border = Color(0xFFE5E7EB);
  static const borderLight = Color(0xFFF3F4F6);

  // Semantic — UNCHANGED
  static const success = Color(0xFF059669);
  static const successLight = Color(0xFFD1FAE5);
  static const warning = Color(0xFFD97706);
  static const warningLight = Color(0xFFFEF3C7);
  static const error = Color(0xFFDC2626);
  static const errorLight = Color(0xFFFEE2E2);
  static const info = Color(0xFF2563EB);
  static const infoLight = Color(0xFFDBEAFE);

  static const overlay = Color(0x80000000);
}
