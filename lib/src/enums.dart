/// Defines the visual style of a SmartSnack notification.
enum SmartSnackStyle {
  /// Green checkmark indicating successful operation
  success,

  /// Red X mark indicating error or failure
  error,

  /// Amber warning icon for cautionary messages
  warning,

  /// Blue info icon for informational messages
  info,

  /// Animated loading indicator with gradient border
  loading,

  /// Fully customizable style with no default theming
  custom,

  /// Minimal neutral style with subtle appearance
  minimal,

  /// Glass morphism style with blur effect
  glass,

  /// Gradient background style
  gradient,

  /// Compact pill style (iOS Dynamic Island collapsed)
  compact,

  /// Banner style (full width notification)
  banner,

  /// Alert style with prominent appearance
  alert,
}

/// Position of the SmartSnack notification on screen.
enum SmartSnackPosition {
  /// Display at the top of the screen (Dynamic Island style)
  top,

  /// Display at the bottom of the screen
  bottom,

  /// Display in the center of the screen
  center,
}

/// Animation style for SmartSnack entrance/exit.
enum SmartSnackAnimation {
  /// Bouncy spring animation (default)
  spring,

  /// Smooth slide animation
  slide,

  /// Fade in/out animation
  fade,

  /// Scale up/down animation
  scale,

  /// Slide from left
  slideLeft,

  /// Slide from right
  slideRight,

  /// Zoom in/out
  zoom,

  /// Bounce drop
  bounce,

  /// Elastic animation
  elastic,

  /// No animation
  none,
}

/// Direction for swipe-to-dismiss gesture.
enum SmartSnackDismissDirection {
  /// Dismiss by swiping up
  up,

  /// Dismiss by swiping down
  down,

  /// Dismiss by swiping left
  left,

  /// Dismiss by swiping right
  right,

  /// Dismiss by swiping horizontally (left or right)
  horizontal,

  /// Dismiss by swiping vertically (up or down)
  vertical,

  /// Dismiss in any direction
  any,

  /// Disable swipe to dismiss
  none,
}

/// Haptic feedback type for SmartSnack interactions.
enum SmartSnackHaptic {
  /// Light haptic feedback
  light,

  /// Medium haptic feedback
  medium,

  /// Heavy haptic feedback
  heavy,

  /// Selection haptic feedback
  selection,

  /// Success pattern haptic feedback (double light)
  success,

  /// Warning pattern haptic feedback
  warning,

  /// Error pattern haptic feedback (heavy + medium)
  error,

  /// Notification haptic
  notification,

  /// Impact haptic
  impact,

  /// No haptic feedback
  none,
}

/// Priority level for queue management.
enum SmartSnackPriority {
  /// Low priority - queued normally, can be skipped
  low,

  /// Normal priority - queued normally (default)
  normal,

  /// High priority - jumps ahead in queue
  high,

  /// Urgent priority - shows immediately, interrupting current snack
  urgent,

  /// Critical priority - cannot be dismissed, persists until manually closed
  critical,
}

/// Icon animation style for status icons.
enum SmartSnackIconAnimation {
  /// Bouncy scale animation
  bounce,

  /// Fade in animation
  fade,

  /// Rotate animation
  rotate,

  /// Pulse animation
  pulse,

  /// Shake animation
  shake,

  /// Flip animation
  flip,

  /// None - instant appearance
  none,
}

/// Edge behavior for notifications
enum SmartSnackEdgeBehavior {
  /// Standard inset from edges
  standard,

  /// Full width to screen edges
  fullWidth,

  /// Floating with rounded corners
  floating,

  /// Attached to notch/dynamic island area
  attachedToNotch,
}

/// Auto-dismiss behavior
enum SmartSnackAutoDismiss {
  /// Dismiss after duration (default)
  afterDuration,

  /// Don't auto-dismiss, require manual interaction
  never,

  /// Dismiss when navigating to another screen
  onNavigation,

  /// Dismiss when app goes to background
  onBackground,
}

/// Content alignment within the notification
enum SmartSnackAlignment {
  /// Align content to start
  start,

  /// Align content to center
  center,

  /// Align content to end
  end,

  /// Spread content evenly
  spaceBetween,
}
