import 'package:flutter/material.dart';
import 'smart_snack_colors.dart';

/// Typography system for SmartSnack notifications.
/// Uses SF Pro Display-inspired system fonts with carefully crafted scales.
class SmartSnackTypography {
  SmartSnackTypography._();

  // ═══════════════════════════════════════════════════════════════════════════
  // FONT FAMILIES
  // ═══════════════════════════════════════════════════════════════════════════

  static const String primaryFontFamily = '.SF Pro Display';
  static const String fallbackFontFamily = 'Roboto';
  
  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT STYLES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Primary title style - Used for main notification text
  static const TextStyle title = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: SmartSnackColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.25,
    decoration: TextDecoration.none,
  );

  /// Large title style - For emphasized notifications
  static const TextStyle titleLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: SmartSnackColors.textPrimary,
    letterSpacing: -0.4,
    height: 1.2,
    decoration: TextDecoration.none,
  );

  /// Subtitle style - For secondary information
  static const TextStyle subtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: SmartSnackColors.textSecondary,
    letterSpacing: 0,
    height: 1.3,
    decoration: TextDecoration.none,
  );

  /// Small text - For timestamps, captions
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: SmartSnackColors.textTertiary,
    letterSpacing: 0.2,
    height: 1.3,
    decoration: TextDecoration.none,
  );

  /// Action button text
  static const TextStyle action = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: SmartSnackColors.info,
    letterSpacing: 0,
    height: 1.2,
    decoration: TextDecoration.none,
  );

  /// Monospace text - For codes, timers
  static const TextStyle monospace = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: SmartSnackColors.textPrimary,
    fontFamily: 'SF Mono',
    fontFamilyFallback: ['Consolas', 'Monaco', 'Courier New'],
    letterSpacing: 0.5,
    height: 1.2,
    decoration: TextDecoration.none,
  );

  /// Compact title - For smaller notifications
  static const TextStyle titleCompact = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: SmartSnackColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.3,
    decoration: TextDecoration.none,
  );
}

/// Spacing and sizing constants for SmartSnack
class SmartSnackSpacing {
  SmartSnackSpacing._();

  // ═══════════════════════════════════════════════════════════════════════════
  // SPACING
  // ═══════════════════════════════════════════════════════════════════════════

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // SNACK DIMENSIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Compact height (iPhone Dynamic Island style)
  static const double heightCompact = 40.0;
  
  /// Default notification height
  static const double heightDefault = 62.0;
  
  /// Expanded notification height (with actions/extra content)
  static const double heightExpanded = 100.0;
  
  /// Large expanded height (full content view)
  static const double heightLarge = 130.0;

  /// Maximum width ratio to screen
  static const double maxWidthRatio = 0.95;
  
  /// Collapsed width (pill shape)
  static const double collapsedWidth = 126.0;

  /// Icon size
  static const double iconSize = 24.0;
  static const double iconSizeSmall = 20.0;
  static const double iconSizeLarge = 28.0;

  /// Avatar size
  static const double avatarSize = 32.0;
  static const double avatarSizeSmall = 24.0;

  /// Border radius
  static const double borderRadiusCompact = 22.0;
  static const double borderRadiusDefault = 32.0;
  static const double borderRadiusExpanded = 28.0;

  /// Icon container size
  static const double iconContainerSize = 36.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // POSITIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Top offset from screen edge
  static const double topOffset = 11.0;
  
  /// Bottom offset from screen edge
  static const double bottomOffset = 34.0;
}

/// Animation durations for SmartSnack
class SmartSnackDurations {
  SmartSnackDurations._();

  /// Quick micro-interactions
  static const Duration micro = Duration(milliseconds: 100);
  
  /// Fast transitions
  static const Duration fast = Duration(milliseconds: 200);
  
  /// Default animation duration
  static const Duration normal = Duration(milliseconds: 350);
  
  /// Slower, more dramatic animations
  static const Duration slow = Duration(milliseconds: 500);
  
  /// Spring animation duration
  static const Duration spring = Duration(milliseconds: 650);
  
  /// Morph/transform animations
  static const Duration morph = Duration(milliseconds: 450);
  
  /// Loading border animation cycle
  static const Duration loadingCycle = Duration(milliseconds: 1800);
  
  /// Shimmer animation cycle
  static const Duration shimmerCycle = Duration(milliseconds: 1500);

  /// Default snack display duration
  static const Duration defaultDisplay = Duration(seconds: 3);
  
  /// Short display duration
  static const Duration shortDisplay = Duration(seconds: 2);
  
  /// Long display duration
  static const Duration longDisplay = Duration(seconds: 5);
}

/// Custom curves for premium animations
class SmartSnackCurves {
  SmartSnackCurves._();

  /// Bouncy spring curve for entrance
  static const Curve springIn = Curves.elasticOut;
  
  /// Smooth exit curve
  static const Curve smoothOut = Curves.easeOutCubic;
  
  /// Fast overshoot for micro-interactions
  static const Curve overshoot = Curves.easeOutBack;
  
  /// Smooth ease for state changes
  static const Curve stateChange = Curves.easeInOutCubic;
  
  /// Deceleration curve
  static const Curve decelerate = Curves.decelerate;
  
  /// Emphasis curve for important animations
  static const Curve emphasis = Curves.easeOutExpo;
}
