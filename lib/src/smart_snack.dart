import 'package:flutter/material.dart';
import 'controller.dart';
import 'enums.dart';
import 'widgets/smart_snack_widget.dart';
import 'theme/smart_snack_colors.dart';

/// SmartSnack - A beautiful Dynamic Island-style notification system for Flutter.
///
/// Features:
/// - 🎨 Beautiful animations and transitions
/// - 🎯 Multiple preset styles (success, error, warning, info, loading)
/// - 💎 Glass morphism and gradient effects
/// - ⚡ Queue management with priorities
/// - 🎭 Fully customizable appearance
/// - 📱 iOS Dynamic Island inspired design
///
/// Basic usage:
/// ```dart
/// SmartSnack.success(context, title: 'Operation completed!');
/// SmartSnack.error(context, title: 'Something went wrong');
/// SmartSnack.loading(context, title: 'Processing...');
/// ```
class SmartSnack {
  static OverlayEntry? _entry;
  static final SmartSnackController _controller = SmartSnackController();

  /// Show a success notification with animated checkmark.
  static void success(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismissed,
    VoidCallback? onTap,
    Widget? leading,
    Widget? trailing,
    SmartSnackPosition position = SmartSnackPosition.top,
    SmartSnackHaptic haptic = SmartSnackHaptic.success,
    List<SmartSnackAction>? actions,
    bool enableGlow = true,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.success,
      duration: duration,
      onDismissed: onDismissed,
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      position: position,
      haptic: haptic,
      actions: actions,
      enableGlow: enableGlow,
    );
  }

  /// Show an error notification with animated X mark.
  static void error(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onDismissed,
    VoidCallback? onTap,
    Widget? leading,
    Widget? trailing,
    SmartSnackPosition position = SmartSnackPosition.top,
    SmartSnackHaptic haptic = SmartSnackHaptic.error,
    List<SmartSnackAction>? actions,
    bool enableGlow = true,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.error,
      duration: duration,
      onDismissed: onDismissed,
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      position: position,
      haptic: haptic,
      actions: actions,
      enableGlow: enableGlow,
    );
  }

  /// Show a warning notification.
  static void warning(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onDismissed,
    VoidCallback? onTap,
    Widget? leading,
    Widget? trailing,
    SmartSnackPosition position = SmartSnackPosition.top,
    SmartSnackHaptic haptic = SmartSnackHaptic.warning,
    List<SmartSnackAction>? actions,
    bool enableGlow = true,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.warning,
      duration: duration,
      onDismissed: onDismissed,
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      position: position,
      haptic: haptic,
      actions: actions,
      enableGlow: enableGlow,
    );
  }

  /// Show an info notification.
  static void info(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismissed,
    VoidCallback? onTap,
    Widget? leading,
    Widget? trailing,
    SmartSnackPosition position = SmartSnackPosition.top,
    SmartSnackHaptic haptic = SmartSnackHaptic.light,
    List<SmartSnackAction>? actions,
    bool enableGlow = false,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.info,
      duration: duration,
      onDismissed: onDismissed,
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      position: position,
      haptic: haptic,
      actions: actions,
      enableGlow: enableGlow,
    );
  }

  /// Show a loading notification with animated gradient border.
  /// Loading notifications don't auto-dismiss - call [dismiss] when done.
  static void loading(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? id,
    VoidCallback? onDismissed,
    Widget? leading,
    Widget? trailing,
    SmartSnackPosition position = SmartSnackPosition.top,
    List<Color>? loadingIndicatorColors,
    SmartSnackHaptic haptic = SmartSnackHaptic.light,
  }) {
    show(
      context,
      id: id,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.loading,
      onDismissed: onDismissed,
      leading: leading,
      trailing: trailing,
      position: position,
      loadingIndicatorColors: loadingIndicatorColors,
      haptic: haptic,
    );
  }

  /// Show a glass morphism style notification with blur effect.
  static void glass(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismissed,
    VoidCallback? onTap,
    Widget? leading,
    Widget? trailing,
    SmartSnackPosition position = SmartSnackPosition.top,
    double blurIntensity = 20,
    List<SmartSnackAction>? actions,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.glass,
      duration: duration,
      onDismissed: onDismissed,
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      position: position,
      enableBlur: true,
      blurIntensity: blurIntensity,
      actions: actions,
    );
  }

  /// Show a gradient style notification.
  static void gradient(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismissed,
    VoidCallback? onTap,
    Widget? leading,
    Widget? trailing,
    List<Color>? gradientColors,
    SmartSnackPosition position = SmartSnackPosition.top,
    List<SmartSnackAction>? actions,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.gradient,
      duration: duration,
      onDismissed: onDismissed,
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      gradientColors: gradientColors ?? SmartSnackColors.premiumGradient,
      position: position,
      actions: actions,
    );
  }

  /// Show a notification with a progress indicator.
  static void progress(
    BuildContext context, {
    required String title,
    required double progress,
    String? id,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismissed,
    Widget? leading,
    Widget? trailing,
    Color? accentColor,
    bool showProgressText = false,
  }) {
    show(
      context,
      id: id,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.custom,
      duration: duration,
      onDismissed: onDismissed,
      leading: leading,
      trailing: trailing,
      progress: progress,
      accentColor: accentColor ?? SmartSnackColors.info,
      showProgressText: showProgressText,
    );
  }

  /// Show a fully customizable notification.
  static void show(
    BuildContext context, {
    String? id,
    required String title,
    String? subtitle,
    required SmartSnackStyle style,
    Duration duration = const Duration(seconds: 3),
    SmartSnackPosition position = SmartSnackPosition.top,
    SmartSnackAnimation animation = SmartSnackAnimation.spring,
    SmartSnackDismissDirection dismissDirection = SmartSnackDismissDirection.up,
    SmartSnackHaptic haptic = SmartSnackHaptic.light,
    SmartSnackPriority priority = SmartSnackPriority.normal,
    VoidCallback? onDismissed,
    VoidCallback? onTap,
    Widget? leading,
    Widget? trailing,
    Widget? bodyWidget,
    List<SmartSnackAction>? actions,
    Color? backgroundColor,
    List<Color>? gradientColors,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    Color? accentColor,
    Color? borderColor,
    double? borderWidth,
    List<Color>? loadingIndicatorColors,
    double? borderRadius,
    bool enableBlur = false,
    double blurIntensity = 20,
    bool enableGlow = true,
    List<BoxShadow>? shadows,
    bool expanded = false,
    double? expandedHeight,
    double? progress,
    bool showProgressText = false,
  }) {
    // Create overlay if needed
    if (_entry == null) {
      _entry = OverlayEntry(
        builder: (context) => SmartSnackWidget(controller: _controller),
      );
      Overlay.of(context).insert(_entry!);
      _controller.setOverlayEntry(_entry);
    }

    // Create and show the request
    _controller.show(SmartSnackRequest(
      id: id,
      title: title,
      subtitle: subtitle,
      style: style,
      duration: duration,
      position: position,
      animation: animation,
      dismissDirection: dismissDirection,
      haptic: haptic,
      priority: priority,
      onDismissed: onDismissed,
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      bodyWidget: bodyWidget,
      actions: actions,
      backgroundColor: backgroundColor,
      gradientColors: gradientColors,
      titleTextStyle: titleTextStyle,
      subtitleTextStyle: subtitleTextStyle,
      accentColor: accentColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      loadingIndicatorColors: loadingIndicatorColors,
      borderRadius: borderRadius,
      enableBlur: enableBlur,
      blurIntensity: blurIntensity,
      enableGlow: enableGlow,
      shadows: shadows,
      expanded: expanded,
      expandedHeight: expandedHeight,
      progress: progress,
      showProgressText: showProgressText,
    ));
  }

  /// Update an existing notification by ID.
  static void update(
    String id,
    SmartSnackRequest Function(SmartSnackRequest) updater,
  ) {
    _controller.update(id, updater);
  }

  /// Dismiss the current notification.
  static void dismiss() {
    _controller.dismiss();
  }

  /// Dismiss a specific notification by ID.
  static void dismissById(String id) {
    _controller.dismissById(id);
  }

  /// Clear all queued notifications.
  static void clearQueue() {
    _controller.clearQueue();
  }

  /// Dismiss all notifications and clear the queue.
  static void dismissAll() {
    _controller.dismissAll();
  }

  /// Check if a notification with the given ID exists.
  static bool hasSnack(String id) {
    return _controller.hasSnack(id);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ADDITIONAL CONVENIENCE METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Show a compact notification (minimal pill style).
  static void compact(
    BuildContext context, {
    required String title,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onTap,
    SmartSnackPosition position = SmartSnackPosition.top,
    Color? backgroundColor,
    Color? textColor,
  }) {
    show(
      context,
      title: title,
      style: SmartSnackStyle.compact,
      duration: duration,
      onTap: onTap,
      position: position,
      backgroundColor: backgroundColor,
      titleTextStyle: textColor != null
          ? TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)
          : null,
    );
  }

  /// Show a banner notification (full-width style).
  static void banner(
    BuildContext context, {
    required String title,
    String? subtitle,
    Widget? leading,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
    List<SmartSnackAction>? actions,
    Color? backgroundColor,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.banner,
      leading: leading,
      duration: duration,
      onTap: onTap,
      actions: actions,
      backgroundColor: backgroundColor,
      borderRadius: 0,
    );
  }

  /// Show an alert notification (prominent attention-grabbing style).
  static void alert(
    BuildContext context, {
    required String title,
    String? subtitle,
    Duration duration = const Duration(seconds: 5),
    VoidCallback? onDismissed,
    VoidCallback? onTap,
    List<SmartSnackAction>? actions,
    SmartSnackHaptic haptic = SmartSnackHaptic.heavy,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.alert,
      duration: duration,
      onDismissed: onDismissed,
      onTap: onTap,
      actions: actions,
      haptic: haptic,
      enableGlow: true,
      priority: SmartSnackPriority.high,
    );
  }

  /// Show a notification with a custom icon.
  static void custom(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? subtitle,
    Color? iconColor,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    List<SmartSnackAction>? actions,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.custom,
      leading: Icon(icon, color: iconColor ?? Colors.white, size: 22),
      backgroundColor: backgroundColor,
      duration: duration,
      onTap: onTap,
      actions: actions,
    );
  }

  /// Show a notification with an image.
  static void withImage(
    BuildContext context, {
    required String title,
    required ImageProvider image,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    double imageSize = 36,
    BorderRadius? imageBorderRadius,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.custom,
      leading: ClipRRect(
        borderRadius: imageBorderRadius ?? BorderRadius.circular(8),
        child: Image(
          image: image,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
        ),
      ),
      duration: duration,
      onTap: onTap,
    );
  }

  /// Show a notification with an avatar and online status.
  static void avatar(
    BuildContext context, {
    required String title,
    required String avatarText,
    String? subtitle,
    Color? avatarColor,
    bool showOnlineStatus = false,
    Color onlineColor = Colors.green,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    show(
      context,
      title: title,
      subtitle: subtitle,
      style: SmartSnackStyle.custom,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: avatarColor ?? SmartSnackColors.neutral600,
            child: Text(
              avatarText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (showOnlineStatus)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: onlineColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
              ),
            ),
        ],
      ),
      duration: duration,
      onTap: onTap,
    );
  }

  /// Show a countdown notification.
  static void countdown(
    BuildContext context, {
    required String title,
    required int seconds,
    String? subtitle,
    VoidCallback? onComplete,
    VoidCallback? onTap,
    Color? accentColor,
  }) {
    int remaining = seconds;
    final id = 'countdown_${DateTime.now().millisecondsSinceEpoch}';

    void updateCountdown() {
      if (remaining <= 0) {
        dismiss();
        onComplete?.call();
        return;
      }

      show(
        context,
        id: id,
        title: title,
        subtitle: subtitle ?? '$remaining seconds remaining',
        style: SmartSnackStyle.custom,
        accentColor: accentColor ?? SmartSnackColors.info,
        progress: remaining / seconds,
        onTap: onTap,
        duration: const Duration(days: 1), // Don't auto-dismiss
      );

      remaining--;
      Future.delayed(const Duration(seconds: 1), updateCountdown);
    }

    updateCountdown();
  }

  /// Show a "do not disturb" notification that blocks further notifications.
  static void doNotDisturb(
    BuildContext context, {
    required Duration duration,
    String title = 'Do Not Disturb',
    String? subtitle,
  }) {
    _controller.setDoNotDisturbMode(true);
    show(
      context,
      title: title,
      subtitle:
          subtitle ?? 'Notifications paused for ${duration.inMinutes} minutes',
      style: SmartSnackStyle.minimal,
      leading: const Icon(Icons.notifications_off_rounded,
          color: Colors.grey, size: 22),
      duration: duration,
      onDismissed: () => _controller.setDoNotDisturbMode(false),
      dismissDirection: SmartSnackDismissDirection.none,
    );
  }

  /// Check if notifications are currently muted.
  static bool get isDoNotDisturbEnabled => _controller.isDoNotDisturbEnabled;

  /// Get the number of notifications in the queue.
  static int get queueLength => _controller.queueLength;

  /// Check if a notification is currently visible.
  static bool get isVisible => _controller.currentSnack.value != null;
}
