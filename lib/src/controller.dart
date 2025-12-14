import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'enums.dart';

/// Request object containing all configuration for a SmartSnack notification.
class SmartSnackRequest {
  /// Unique identifier for this snack (for updates)
  final String? id;

  /// Main title text
  final String title;

  /// Optional subtitle text
  final String? subtitle;

  /// Visual style preset
  final SmartSnackStyle style;

  /// How long to display (ignored for loading style)
  final Duration duration;

  /// Screen position
  final SmartSnackPosition position;

  /// Entrance/exit animation style
  final SmartSnackAnimation animation;

  /// Swipe dismiss direction
  final SmartSnackDismissDirection dismissDirection;

  /// Haptic feedback on show
  final SmartSnackHaptic haptic;

  /// Queue priority
  final SmartSnackPriority priority;

  /// Callback when dismissed
  final VoidCallback? onDismissed;

  /// Callback when tapped
  final VoidCallback? onTap;

  // ═══════════════════════════════════════════════════════════════════════════
  // CUSTOMIZATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Custom leading widget (replaces default icon)
  final Widget? leading;

  /// Custom trailing widget
  final Widget? trailing;

  /// Custom body widget (replaces title/subtitle)
  final Widget? bodyWidget;

  /// List of action buttons
  final List<SmartSnackAction>? actions;

  // ═══════════════════════════════════════════════════════════════════════════
  // STYLING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Custom background color
  final Color? backgroundColor;

  /// Gradient colors for gradient style
  final List<Color>? gradientColors;

  /// Custom title text style
  final TextStyle? titleTextStyle;

  /// Custom subtitle text style
  final TextStyle? subtitleTextStyle;

  /// Custom accent color
  final Color? accentColor;

  /// Custom border color
  final Color? borderColor;

  /// Border width
  final double? borderWidth;

  /// Loading indicator gradient colors
  final List<Color>? loadingIndicatorColors;

  /// Custom border radius
  final double? borderRadius;

  /// Enable/disable blur effect
  final bool enableBlur;

  /// Blur intensity (sigma)
  final double blurIntensity;

  /// Enable/disable glow effect
  final bool enableGlow;

  /// Custom shadow
  final List<BoxShadow>? shadows;

  // ═══════════════════════════════════════════════════════════════════════════
  // EXPANDED MODE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Enable expanded mode for more content
  final bool expanded;

  /// Custom height (only in expanded mode)
  final double? expandedHeight;

  /// Progress value (0.0 - 1.0) for progress indicator
  final double? progress;

  /// Show progress as percentage text
  final bool showProgressText;

  // ═══════════════════════════════════════════════════════════════════════════
  // ACCESSIBILITY & RTL
  // ═══════════════════════════════════════════════════════════════════════════

  /// Text direction for RTL support
  final TextDirection? textDirection;

  /// Semantic label for screen readers (auto-generated if null)
  final String? semanticLabel;

  SmartSnackRequest({
    this.id,
    required this.title,
    this.subtitle,
    required this.style,
    this.duration = const Duration(seconds: 3),
    this.position = SmartSnackPosition.top,
    this.animation = SmartSnackAnimation.spring,
    this.dismissDirection = SmartSnackDismissDirection.up,
    this.haptic = SmartSnackHaptic.light,
    this.priority = SmartSnackPriority.normal,
    this.onDismissed,
    this.onTap,
    this.leading,
    this.trailing,
    this.bodyWidget,
    this.actions,
    this.backgroundColor,
    this.gradientColors,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.accentColor,
    this.borderColor,
    this.borderWidth,
    this.loadingIndicatorColors,
    this.borderRadius,
    this.enableBlur = false,
    this.blurIntensity = 20,
    this.enableGlow = true,
    this.shadows,
    this.expanded = false,
    this.expandedHeight,
    this.progress,
    this.showProgressText = false,
    this.textDirection,
    this.semanticLabel,
  });

  /// Create a copy with updated properties
  SmartSnackRequest copyWith({
    String? id,
    String? title,
    String? subtitle,
    SmartSnackStyle? style,
    Duration? duration,
    SmartSnackPosition? position,
    SmartSnackAnimation? animation,
    SmartSnackDismissDirection? dismissDirection,
    SmartSnackHaptic? haptic,
    SmartSnackPriority? priority,
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
    bool? enableBlur,
    double? blurIntensity,
    bool? enableGlow,
    List<BoxShadow>? shadows,
    bool? expanded,
    double? expandedHeight,
    double? progress,
    bool? showProgressText,
    TextDirection? textDirection,
    String? semanticLabel,
  }) {
    return SmartSnackRequest(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      style: style ?? this.style,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      animation: animation ?? this.animation,
      dismissDirection: dismissDirection ?? this.dismissDirection,
      haptic: haptic ?? this.haptic,
      priority: priority ?? this.priority,
      onDismissed: onDismissed ?? this.onDismissed,
      onTap: onTap ?? this.onTap,
      leading: leading ?? this.leading,
      trailing: trailing ?? this.trailing,
      bodyWidget: bodyWidget ?? this.bodyWidget,
      actions: actions ?? this.actions,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradientColors: gradientColors ?? this.gradientColors,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      accentColor: accentColor ?? this.accentColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      loadingIndicatorColors:
          loadingIndicatorColors ?? this.loadingIndicatorColors,
      borderRadius: borderRadius ?? this.borderRadius,
      enableBlur: enableBlur ?? this.enableBlur,
      blurIntensity: blurIntensity ?? this.blurIntensity,
      enableGlow: enableGlow ?? this.enableGlow,
      shadows: shadows ?? this.shadows,
      expanded: expanded ?? this.expanded,
      expandedHeight: expandedHeight ?? this.expandedHeight,
      progress: progress ?? this.progress,
      showProgressText: showProgressText ?? this.showProgressText,
      textDirection: textDirection ?? this.textDirection,
      semanticLabel: semanticLabel ?? this.semanticLabel,
    );
  }
}

/// Action button for SmartSnack notifications.
class SmartSnackAction {
  /// Button label
  final String label;

  /// Action callback
  final VoidCallback onPressed;

  /// Text color
  final Color? textColor;

  /// Background color
  final Color? backgroundColor;

  /// Whether tapping dismisses the snack
  final bool dismissOnTap;

  /// Icon to show before label
  final IconData? icon;

  const SmartSnackAction({
    required this.label,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.dismissOnTap = true,
    this.icon,
  });
}

/// Controller for managing SmartSnack notifications.
/// Handles queue management, animations, and state.
class SmartSnackController {
  static final SmartSnackController _instance =
      SmartSnackController._internal();

  factory SmartSnackController() => _instance;

  SmartSnackController._internal();

  // Queue for pending notifications
  final Queue<SmartSnackRequest> _queue = Queue();

  // High priority queue
  final Queue<SmartSnackRequest> _highPriorityQueue = Queue();

  // Current snack notifier
  final ValueNotifier<SmartSnackRequest?> currentSnack = ValueNotifier(null);

  // Animation state notifier
  final ValueNotifier<bool> isAnimating = ValueNotifier(false);

  // Auto dismiss timer
  Timer? _autoDismissTimer;

  // Overlay entry reference
  OverlayEntry? _overlayEntry;

  // Map of active snacks by ID for updates
  final Map<String, SmartSnackRequest> _activeSnacks = {};

  /// Show a new SmartSnack notification.
  void show(SmartSnackRequest request) {
    // Trigger haptic feedback
    _triggerHaptic(request.haptic, request.style);

    // Handle urgent priority - show immediately
    if (request.priority == SmartSnackPriority.urgent) {
      _forceShow(request);
      return;
    }

    // If nothing is showing, show immediately
    if (currentSnack.value == null) {
      _showNow(request);
      return;
    }

    // Handle high priority
    if (request.priority == SmartSnackPriority.high) {
      _highPriorityQueue.add(request);
    } else {
      _queue.add(request);
    }

    // If current is loading and new one is not, transition
    if (currentSnack.value!.style == SmartSnackStyle.loading &&
        request.style != SmartSnackStyle.loading) {
      _showNext();
    }
  }

  /// Update an existing snack by ID.
  void update(
      String id, SmartSnackRequest Function(SmartSnackRequest) updater) {
    if (_activeSnacks.containsKey(id)) {
      final current = _activeSnacks[id]!;
      final updated = updater(current);
      _activeSnacks[id] = updated;

      if (currentSnack.value?.id == id) {
        currentSnack.value = updated;
        _scheduleDismiss(updated);
      }
    }
  }

  /// Dismiss the current snack.
  void dismiss() {
    _autoDismissTimer?.cancel();

    final current = currentSnack.value;
    if (current?.id != null) {
      _activeSnacks.remove(current!.id);
    }

    current?.onDismissed?.call();
    currentSnack.value = null;

    // Wait for exit animation then show next
    Future.delayed(const Duration(milliseconds: 400), () {
      _showNext();
    });
  }

  /// Dismiss a specific snack by ID.
  void dismissById(String id) {
    if (currentSnack.value?.id == id) {
      dismiss();
    } else {
      _queue.removeWhere((r) => r.id == id);
      _highPriorityQueue.removeWhere((r) => r.id == id);
      _activeSnacks.remove(id);
    }
  }

  /// Clear all queued notifications.
  void clearQueue() {
    _queue.clear();
    _highPriorityQueue.clear();
  }

  /// Dismiss all and clear queue.
  void dismissAll() {
    clearQueue();
    dismiss();
  }

  void _showNow(SmartSnackRequest request) {
    if (request.id != null) {
      _activeSnacks[request.id!] = request;
    }

    currentSnack.value = request;
    _scheduleDismiss(request);
  }

  void _forceShow(SmartSnackRequest request) {
    _autoDismissTimer?.cancel();

    // Move current to front of queue if it exists
    final current = currentSnack.value;
    if (current != null) {
      _highPriorityQueue.addFirst(current);
    }

    _showNow(request);
  }

  void _scheduleDismiss(SmartSnackRequest request) {
    _autoDismissTimer?.cancel();

    // Loading style doesn't auto-dismiss
    if (request.style == SmartSnackStyle.loading) {
      return;
    }

    _autoDismissTimer = Timer(request.duration, () {
      dismiss();
    });
  }

  void _showNext() {
    // Check high priority queue first
    if (_highPriorityQueue.isNotEmpty) {
      final next = _highPriorityQueue.removeFirst();
      _showNow(next);
      return;
    }

    // Then regular queue
    if (_queue.isNotEmpty) {
      final next = _queue.removeFirst();
      _showNow(next);
      return;
    }

    // Nothing more to show
    currentSnack.value = null;
  }

  void _triggerHaptic(SmartSnackHaptic haptic, SmartSnackStyle style) {
    switch (haptic) {
      case SmartSnackHaptic.light:
        HapticFeedback.lightImpact();
        break;
      case SmartSnackHaptic.medium:
        HapticFeedback.mediumImpact();
        break;
      case SmartSnackHaptic.heavy:
        HapticFeedback.heavyImpact();
        break;
      case SmartSnackHaptic.selection:
        HapticFeedback.selectionClick();
        break;
      case SmartSnackHaptic.success:
        HapticFeedback.lightImpact();
        Future.delayed(const Duration(milliseconds: 100), () {
          HapticFeedback.lightImpact();
        });
        break;
      case SmartSnackHaptic.warning:
        HapticFeedback.mediumImpact();
        break;
      case SmartSnackHaptic.error:
        HapticFeedback.heavyImpact();
        Future.delayed(const Duration(milliseconds: 100), () {
          HapticFeedback.mediumImpact();
        });
        break;
      case SmartSnackHaptic.notification:
        HapticFeedback.selectionClick();
        Future.delayed(const Duration(milliseconds: 50), () {
          HapticFeedback.lightImpact();
        });
        break;
      case SmartSnackHaptic.impact:
        HapticFeedback.heavyImpact();
        break;
      case SmartSnackHaptic.none:
        break;
    }
  }

  /// Set overlay entry reference.
  void setOverlayEntry(OverlayEntry? entry) {
    _overlayEntry = entry;
  }

  /// Get overlay entry reference.
  OverlayEntry? getOverlayEntry() => _overlayEntry;

  /// Check if snack with ID exists.
  bool hasSnack(String id) => _activeSnacks.containsKey(id);

  // Do Not Disturb mode
  bool _doNotDisturbMode = false;

  /// Enable or disable Do Not Disturb mode.
  void setDoNotDisturbMode(bool enabled) {
    _doNotDisturbMode = enabled;
  }

  /// Check if Do Not Disturb mode is enabled.
  bool get isDoNotDisturbEnabled => _doNotDisturbMode;

  /// Get the number of notifications in the queue.
  int get queueLength => _queue.length + _highPriorityQueue.length;
}
