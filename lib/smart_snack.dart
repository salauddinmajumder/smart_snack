/// SmartSnack - A beautiful Dynamic Island-style notification system for Flutter.
/// 
/// This package provides a premium notification experience inspired by iOS Dynamic Island.
/// 
/// Features:
/// - 🎨 Beautiful animations and spring physics
/// - 🎯 Multiple preset styles (success, error, warning, info, loading)
/// - 💎 Glass morphism and gradient effects
/// - ⚡ Smart queue management with priorities
/// - 🎭 Fully customizable appearance
/// - 📱 iOS Dynamic Island inspired design
/// - 🔄 Progress indicators and action buttons
/// - 📳 Haptic feedback support
/// 
/// ## Quick Start
/// 
/// ```dart
/// // Simple notifications
/// SmartSnack.success(context, title: 'Saved successfully!');
/// SmartSnack.error(context, title: 'Something went wrong');
/// SmartSnack.warning(context, title: 'Low battery');
/// SmartSnack.info(context, title: 'New update available');
/// 
/// // Loading state
/// SmartSnack.loading(context, title: 'Processing...');
/// // ... do work
/// SmartSnack.dismiss();
/// 
/// // With subtitle
/// SmartSnack.success(
///   context,
///   title: 'Payment Received',
///   subtitle: '\$50.00 from John',
/// );
/// 
/// // With actions
/// SmartSnack.info(
///   context,
///   title: 'New message',
///   actions: [
///     SmartSnackAction(label: 'View', onPressed: () => viewMessage()),
///     SmartSnackAction(label: 'Dismiss', onPressed: () {}),
///   ],
/// );
/// ```
library smart_snack;

// Core exports
export 'src/smart_snack.dart';
export 'src/enums.dart';
export 'src/controller.dart' show SmartSnackRequest, SmartSnackAction, SmartSnackController;

// Theme exports
export 'src/theme/smart_snack_colors.dart';
export 'src/theme/smart_snack_theme.dart';

// Widget exports for advanced customization
export 'src/widgets/smart_snack_components.dart'
    show
        GlassContainer,
        AnimatedSmartIcon,
        PulsingIndicator,
        AnimatedCheckmark,
        AnimatedXMark,
        GlowingIconContainer,
        GradientProgressBar,
        GradientCircularProgress,
        StatusAvatar,
        CountdownTimer;

// Animation exports for advanced customization
export 'src/animations/smart_snack_animations.dart'
    show AnimatedGradientBorderPainter, ShimmerPainter, WavePainter; 
