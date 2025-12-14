import 'package:flutter/material.dart';

/// A sophisticated color palette for SmartSnack notifications.
/// Designed using color theory principles for maximum visual appeal.
class SmartSnackColors {
  SmartSnackColors._();

  // ═══════════════════════════════════════════════════════════════════════════
  // PRIMARY SEMANTIC COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Success Green - Fresh, modern, and trustworthy
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);
  static const Color successSurface = Color(0xFF0D3D2C);

  /// Error Red - Attention-grabbing but not aggressive
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorSurface = Color(0xFF3D1414);

  /// Warning Amber - Warm and noticeable
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningSurface = Color(0xFF3D2F0B);

  /// Info Blue - Calm and informative
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoSurface = Color(0xFF0F1E3D);

  /// Loading - Dynamic and active
  static const Color loading = Color(0xFF8B5CF6);
  static const Color loadingLight = Color(0xFFA78BFA);
  static const Color loadingDark = Color(0xFF7C3AED);

  // ═══════════════════════════════════════════════════════════════════════════
  // NEUTRAL PALETTE
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color neutral900 = Color(0xFF0A0A0A);
  static const Color neutral800 = Color(0xFF171717);
  static const Color neutral700 = Color(0xFF262626);
  static const Color neutral600 = Color(0xFF404040);
  static const Color neutral500 = Color(0xFF525252);
  static const Color neutral400 = Color(0xFF737373);
  static const Color neutral300 = Color(0xFFA3A3A3);
  static const Color neutral200 = Color(0xFFD4D4D4);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral50 = Color(0xFFFAFAFA);

  // ═══════════════════════════════════════════════════════════════════════════
  // BACKGROUND COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary dark background with slight transparency for glass effect
  static const Color backgroundDark = Color(0xF5141414);
  static const Color backgroundDarkSolid = Color(0xFF141414);

  /// Glass morphism background
  static Color glassBackground = Colors.white.withValues(alpha: 0.08);
  static Color glassBorder = Colors.white.withValues(alpha: 0.12);

  // ═══════════════════════════════════════════════════════════════════════════
  // PREMIUM GRADIENTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Success gradient - Fresh and modern
  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF14B8A6),
  ];

  /// Error gradient - Vibrant attention
  static const List<Color> errorGradient = [
    Color(0xFFEF4444),
    Color(0xFFF97316),
  ];

  /// Warning gradient - Warm glow
  static const List<Color> warningGradient = [
    Color(0xFFF59E0B),
    Color(0xFFEAB308),
  ];

  /// Info gradient - Cool and calm
  static const List<Color> infoGradient = [
    Color(0xFF3B82F6),
    Color(0xFF06B6D4),
  ];

  /// Loading gradient - Dynamic rainbow for animated border
  static const List<Color> loadingGradient = [
    Color(0xFF8B5CF6), // Purple
    Color(0xFFEC4899), // Pink
    Color(0xFFF43F5E), // Rose
    Color(0xFFF97316), // Orange
    Color(0xFFFBBF24), // Yellow
    Color(0xFF22C55E), // Green
    Color(0xFF06B6D4), // Cyan
    Color(0xFF3B82F6), // Blue
    Color(0xFF8B5CF6), // Back to Purple
  ];

  /// Premium purple gradient
  static const List<Color> premiumGradient = [
    Color(0xFF8B5CF6),
    Color(0xFFD946EF),
  ];

  /// Neutral subtle gradient for glass effect
  static const List<Color> neutralGradient = [
    Color(0xFF374151),
    Color(0xFF1F2937),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // GLOW COLORS (For shadows and effects)
  // ═══════════════════════════════════════════════════════════════════════════

  static Color successGlow = success.withValues(alpha: 0.4);
  static Color errorGlow = error.withValues(alpha: 0.4);
  static Color warningGlow = warning.withValues(alpha: 0.4);
  static Color infoGlow = info.withValues(alpha: 0.4);
  static Color loadingGlow = loading.withValues(alpha: 0.3);

  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFA3A3A3);
  static const Color textTertiary = Color(0xFF737373);
  static const Color textOnSuccess = Color(0xFFFFFFFF);
  static const Color textOnError = Color(0xFFFFFFFF);
  static const Color textOnWarning = Color(0xFF1C1917);
  static const Color textOnInfo = Color(0xFFFFFFFF);

  // ═══════════════════════════════════════════════════════════════════════════
  // ICON COLORS
  // ═══════════════════════════════════════════════════════════════════════════

  static const Color iconPrimary = Color(0xFFFAFAFA);
  static const Color iconSecondary = Color(0xFFA3A3A3);

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Returns the accent color for a given style
  static Color getAccentColor(SmartSnackColorStyle style) {
    switch (style) {
      case SmartSnackColorStyle.success:
        return success;
      case SmartSnackColorStyle.error:
        return error;
      case SmartSnackColorStyle.warning:
        return warning;
      case SmartSnackColorStyle.info:
        return info;
      case SmartSnackColorStyle.loading:
        return loading;
      case SmartSnackColorStyle.neutral:
        return neutral400;
    }
  }

  /// Returns the gradient for a given style
  static List<Color> getGradient(SmartSnackColorStyle style) {
    switch (style) {
      case SmartSnackColorStyle.success:
        return successGradient;
      case SmartSnackColorStyle.error:
        return errorGradient;
      case SmartSnackColorStyle.warning:
        return warningGradient;
      case SmartSnackColorStyle.info:
        return infoGradient;
      case SmartSnackColorStyle.loading:
        return loadingGradient;
      case SmartSnackColorStyle.neutral:
        return neutralGradient;
    }
  }

  /// Returns the glow color for a given style
  static Color getGlowColor(SmartSnackColorStyle style) {
    switch (style) {
      case SmartSnackColorStyle.success:
        return successGlow;
      case SmartSnackColorStyle.error:
        return errorGlow;
      case SmartSnackColorStyle.warning:
        return warningGlow;
      case SmartSnackColorStyle.info:
        return infoGlow;
      case SmartSnackColorStyle.loading:
        return loadingGlow;
      case SmartSnackColorStyle.neutral:
        return Colors.transparent;
    }
  }

  /// Returns the surface color for a given style (for subtle backgrounds)
  static Color getSurfaceColor(SmartSnackColorStyle style) {
    switch (style) {
      case SmartSnackColorStyle.success:
        return successSurface;
      case SmartSnackColorStyle.error:
        return errorSurface;
      case SmartSnackColorStyle.warning:
        return warningSurface;
      case SmartSnackColorStyle.info:
        return infoSurface;
      case SmartSnackColorStyle.loading:
        return neutral800;
      case SmartSnackColorStyle.neutral:
        return neutral800;
    }
  }
}

/// Color styles for SmartSnack notifications
enum SmartSnackColorStyle {
  success,
  error,
  warning,
  info,
  loading,
  neutral,
}
