import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/smart_snack_colors.dart';
import '../theme/smart_snack_theme.dart';

/// A premium glass-morphic container with blur effects
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double blurAmount;
  final List<BoxShadow>? shadows;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = SmartSnackSpacing.borderRadiusDefault,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.5,
    this.blurAmount = 20,
    this.shadows,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? SmartSnackColors.glassBackground,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? SmartSnackColors.glassBorder,
              width: borderWidth,
            ),
            boxShadow: shadows,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Animated icon with scale and fade effects
class AnimatedSmartIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;
  final Duration duration;
  final Curve curve;
  final bool animate;

  const AnimatedSmartIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = SmartSnackSpacing.iconSize,
    this.duration = SmartSnackDurations.normal,
    this.curve = Curves.elasticOut,
    this.animate = true,
  });

  @override
  State<AnimatedSmartIcon> createState() => _AnimatedSmartIconState();
}

class _AnimatedSmartIconState extends State<AnimatedSmartIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedSmartIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.icon != oldWidget.icon && widget.animate) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Icon(
              widget.icon,
              color: widget.color,
              size: widget.size,
            ),
          ),
        );
      },
    );
  }
}

/// Pulsing indicator for loading/active states
class PulsingIndicator extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const PulsingIndicator({
    super.key,
    this.color = SmartSnackColors.loading,
    this.size = 10,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<PulsingIndicator> createState() => _PulsingIndicatorState();
}

class _PulsingIndicatorState extends State<PulsingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 0.8 + 0.4 * (0.5 + 0.5 * (_controller.value * 3.14159 * 2).cos());
        final opacity = 0.5 + 0.5 * (0.5 + 0.5 * (_controller.value * 3.14159 * 2).sin());
        
        return Transform.scale(
          scale: scale,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color.withValues(alpha: opacity),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.4 * opacity),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Animated check mark for success states
class AnimatedCheckmark extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;
  final double strokeWidth;

  const AnimatedCheckmark({
    super.key,
    this.color = SmartSnackColors.success,
    this.size = 24,
    this.duration = const Duration(milliseconds: 500),
    this.strokeWidth = 3,
  });

  @override
  State<AnimatedCheckmark> createState() => _AnimatedCheckmarkState();
}

class _AnimatedCheckmarkState extends State<AnimatedCheckmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _CheckmarkPainter(
            progress: _animation.value,
            color: widget.color,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

class _CheckmarkPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _CheckmarkPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    
    // Checkmark points (normalized 0-1)
    const p1 = Offset(0.2, 0.55);
    const p2 = Offset(0.4, 0.75);
    const p3 = Offset(0.8, 0.3);

    // Scale to size
    final sp1 = Offset(p1.dx * size.width, p1.dy * size.height);
    final sp2 = Offset(p2.dx * size.width, p2.dy * size.height);
    final sp3 = Offset(p3.dx * size.width, p3.dy * size.height);

    // First segment length
    final firstLen = (sp2 - sp1).distance;
    final secondLen = (sp3 - sp2).distance;
    final totalLen = firstLen + secondLen;

    final drawn = progress * totalLen;

    path.moveTo(sp1.dx, sp1.dy);

    if (drawn <= firstLen) {
      final t = drawn / firstLen;
      final point = Offset.lerp(sp1, sp2, t)!;
      path.lineTo(point.dx, point.dy);
    } else {
      path.lineTo(sp2.dx, sp2.dy);
      final t = (drawn - firstLen) / secondLen;
      final point = Offset.lerp(sp2, sp3, t)!;
      path.lineTo(point.dx, point.dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Animated X mark for error states
class AnimatedXMark extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;
  final double strokeWidth;

  const AnimatedXMark({
    super.key,
    this.color = SmartSnackColors.error,
    this.size = 24,
    this.duration = const Duration(milliseconds: 400),
    this.strokeWidth = 3,
  });

  @override
  State<AnimatedXMark> createState() => _AnimatedXMarkState();
}

class _AnimatedXMarkState extends State<AnimatedXMark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _XMarkPainter(
            progress: _animation.value,
            color: widget.color,
            strokeWidth: widget.strokeWidth,
          ),
        );
      },
    );
  }
}

class _XMarkPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _XMarkPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final margin = size.width * 0.2;
    
    // First line (top-left to bottom-right)
    if (progress > 0) {
      final p = (progress * 2).clamp(0.0, 1.0);
      final start = Offset(margin, margin);
      final end = Offset(size.width - margin, size.height - margin);
      final current = Offset.lerp(start, end, p)!;
      canvas.drawLine(start, current, paint);
    }

    // Second line (top-right to bottom-left)
    if (progress > 0.5) {
      final p = ((progress - 0.5) * 2).clamp(0.0, 1.0);
      final start = Offset(size.width - margin, margin);
      final end = Offset(margin, size.height - margin);
      final current = Offset.lerp(start, end, p)!;
      canvas.drawLine(start, current, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _XMarkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Glowing icon container with accent color
class GlowingIconContainer extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double glowRadius;
  final double size;

  const GlowingIconContainer({
    super.key,
    required this.child,
    required this.glowColor,
    this.glowRadius = 12,
    this.size = SmartSnackSpacing.iconContainerSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: glowColor.withValues(alpha: 0.15),
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(alpha: 0.3),
            blurRadius: glowRadius,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

/// Linear progress indicator with gradient
class GradientProgressBar extends StatelessWidget {
  final double progress;
  final List<Color> gradientColors;
  final Color trackColor;
  final double height;
  final double borderRadius;

  const GradientProgressBar({
    super.key,
    required this.progress,
    this.gradientColors = SmartSnackColors.premiumGradient,
    this.trackColor = SmartSnackColors.neutral700,
    this.height = 4,
    this.borderRadius = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: trackColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: gradientColors.first.withValues(alpha: 0.5),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Circular progress indicator with gradient
class GradientCircularProgress extends StatefulWidget {
  final double progress;
  final List<Color> gradientColors;
  final Color trackColor;
  final double size;
  final double strokeWidth;
  final Widget? child;
  final bool indeterminate;

  const GradientCircularProgress({
    super.key,
    this.progress = 0,
    this.gradientColors = SmartSnackColors.loadingGradient,
    this.trackColor = SmartSnackColors.neutral700,
    this.size = 24,
    this.strokeWidth = 3,
    this.child,
    this.indeterminate = false,
  });

  @override
  State<GradientCircularProgress> createState() =>
      _GradientCircularProgressState();
}

class _GradientCircularProgressState extends State<GradientCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: SmartSnackDurations.loadingCycle,
    );
    if (widget.indeterminate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(GradientCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.indeterminate && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.indeterminate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _GradientCircularPainter(
              progress: widget.indeterminate ? null : widget.progress,
              rotation: _controller.value,
              gradientColors: widget.gradientColors,
              trackColor: widget.trackColor,
              strokeWidth: widget.strokeWidth,
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _GradientCircularPainter extends CustomPainter {
  final double? progress;
  final double rotation;
  final List<Color> gradientColors;
  final Color trackColor;
  final double strokeWidth;

  _GradientCircularPainter({
    this.progress,
    required this.rotation,
    required this.gradientColors,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Gradient paint
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      colors: gradientColors,
      transform: GradientRotation(rotation * 3.14159 * 2),
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (progress != null) {
      // Determinate progress
      canvas.drawArc(
        rect,
        -3.14159 / 2,
        progress! * 3.14159 * 2,
        false,
        progressPaint,
      );
    } else {
      // Indeterminate spinning
      canvas.drawArc(
        rect,
        rotation * 3.14159 * 2,
        3.14159 * 1.5,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GradientCircularPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.rotation != rotation;
  }
}

/// Avatar with online status indicator
class StatusAvatar extends StatelessWidget {
  final ImageProvider? image;
  final Widget? child;
  final double size;
  final Color statusColor;
  final bool showStatus;
  final double statusSize;

  const StatusAvatar({
    super.key,
    this.image,
    this.child,
    this.size = SmartSnackSpacing.avatarSize,
    this.statusColor = SmartSnackColors.success,
    this.showStatus = false,
    this.statusSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          CircleAvatar(
            radius: size / 2,
            backgroundImage: image,
            backgroundColor: SmartSnackColors.neutral700,
            child: image == null ? child : null,
          ),
          if (showStatus)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: statusSize,
                height: statusSize,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: SmartSnackColors.backgroundDarkSolid,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Countdown timer widget
class CountdownTimer extends StatefulWidget {
  final int seconds;
  final TextStyle? textStyle;
  final VoidCallback? onComplete;

  const CountdownTimer({
    super.key,
    required this.seconds,
    this.textStyle,
    this.onComplete,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.seconds;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    );

    _controller.addListener(() {
      final newSeconds =
          ((1 - _controller.value) * widget.seconds).ceil();
      if (newSeconds != _remainingSeconds) {
        setState(() {
          _remainingSeconds = newSeconds;
        });
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_remainingSeconds),
      style: widget.textStyle ?? SmartSnackTypography.monospace,
    );
  }
}

extension on double {
  double cos() => __cos(this);
  double sin() => __sin(this);
}

double __cos(double x) {
  return 0.5 + 0.5 * (1 - (x % 1) * 2).abs().clamp(-1, 1);
}

double __sin(double x) {
  final normalized = (x + 0.25) % 1;
  return 0.5 + 0.5 * (1 - (normalized * 2 - 1).abs() * 2).clamp(-1, 1);
}
