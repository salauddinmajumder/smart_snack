import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Premium animation configurations for SmartSnack.
/// Uses physics-based spring animations for natural, fluid motion.
class SmartSnackAnimations {
  SmartSnackAnimations._();

  // ═══════════════════════════════════════════════════════════════════════════
  // SPRING CONFIGURATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Bouncy spring for entrance animations
  static const SpringDescription bouncySpring = SpringDescription(
    mass: 1.0,
    stiffness: 400.0,
    damping: 18.0,
  );

  /// Gentle spring for subtle movements
  static const SpringDescription gentleSpring = SpringDescription(
    mass: 1.0,
    stiffness: 200.0,
    damping: 20.0,
  );

  /// Snappy spring for quick interactions
  static const SpringDescription snappySpring = SpringDescription(
    mass: 0.8,
    stiffness: 500.0,
    damping: 22.0,
  );

  /// Smooth spring for state changes
  static const SpringDescription smoothSpring = SpringDescription(
    mass: 1.0,
    stiffness: 300.0,
    damping: 25.0,
  );
}

/// Custom tween for morphing between shapes
class MorphTween extends Tween<double> {
  MorphTween({super.begin, super.end});

  @override
  double lerp(double t) {
    // Apply a custom easing for smoother morphing
    final easedT = Curves.easeInOutCubic.transform(t);
    return super.lerp(easedT);
  }
}

/// Animated gradient border painter for loading states
class AnimatedGradientBorderPainter extends CustomPainter {
  final double animationValue;
  final double borderRadius;
  final List<Color> colors;
  final double strokeWidth;
  final double glowIntensity;

  AnimatedGradientBorderPainter({
    required this.animationValue,
    required this.borderRadius,
    required this.colors,
    this.strokeWidth = 2.5,
    this.glowIntensity = 0.6,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Calculate even stops for gradient
    final stops = <double>[];
    for (int i = 0; i < colors.length; i++) {
      stops.add(i / (colors.length - 1));
    }

    // Create rotating sweep gradient
    final gradient = SweepGradient(
      colors: colors,
      stops: stops,
      transform: GradientRotation(animationValue * 2 * math.pi),
    );

    // Draw glow layer first
    if (glowIntensity > 0) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 6
        ..shader = gradient.createShader(rect)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8 * glowIntensity);
      canvas.drawRRect(rrect, glowPaint);
    }

    // Draw main border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect);
    canvas.drawRRect(rrect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant AnimatedGradientBorderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.glowIntensity != glowIntensity;
  }
}

/// Shimmer effect painter for loading states
class ShimmerPainter extends CustomPainter {
  final double animationValue;
  final Color baseColor;
  final Color highlightColor;
  final double borderRadius;

  ShimmerPainter({
    required this.animationValue,
    required this.baseColor,
    required this.highlightColor,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Calculate shimmer position
    final shimmerStart = -0.5 + (animationValue * 2);
    final shimmerEnd = shimmerStart + 0.5;

    final gradient = LinearGradient(
      begin: Alignment(shimmerStart, 0),
      end: Alignment(shimmerEnd, 0),
      colors: [
        baseColor,
        highlightColor,
        baseColor,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final paint = Paint()..shader = gradient.createShader(rect);

    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawRect(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ShimmerPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

/// Pulse animation painter for success/notification indicators
class PulsePainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final double maxRadius;

  PulsePainter({
    required this.animationValue,
    required this.color,
    required this.maxRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = maxRadius * animationValue;
    final opacity = 1.0 - animationValue;

    final paint = Paint()
      ..color = color.withValues(alpha: opacity * 0.6)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant PulsePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

/// Progress arc painter for circular progress indicators
class ProgressArcPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  ProgressArcPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    this.strokeWidth = 3.0,
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

    // Draw progress
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// Particle system for celebration effects
class ParticleSystem {
  final List<Particle> particles = [];
  final math.Random _random = math.Random();

  void addParticles({
    required int count,
    required Offset origin,
    required List<Color> colors,
    double spread = 50,
    double velocity = 100,
  }) {
    for (int i = 0; i < count; i++) {
      final angle = _random.nextDouble() * 2 * math.pi;
      final speed = velocity * (0.5 + _random.nextDouble() * 0.5);

      particles.add(Particle(
        position: origin,
        velocity: Offset(
          math.cos(angle) * speed,
          math.sin(angle) * speed - 50, // Bias upward
        ),
        color: colors[_random.nextInt(colors.length)],
        size: 4 + _random.nextDouble() * 4,
        life: 1.0,
        decay: 0.02 + _random.nextDouble() * 0.02,
      ));
    }
  }

  void update(double dt) {
    for (int i = particles.length - 1; i >= 0; i--) {
      final p = particles[i];
      p.position += p.velocity * dt;
      p.velocity += const Offset(0, 200) * dt; // Gravity
      p.life -= p.decay;

      if (p.life <= 0) {
        particles.removeAt(i);
      }
    }
  }

  void paint(Canvas canvas) {
    for (final p in particles) {
      final paint = Paint()
        ..color = p.color.withValues(alpha: p.life.clamp(0, 1))
        ..style = PaintingStyle.fill;
      canvas.drawCircle(p.position, p.size * p.life, paint);
    }
  }
}

class Particle {
  Offset position;
  Offset velocity;
  Color color;
  double size;
  double life;
  double decay;

  Particle({
    required this.position,
    required this.velocity,
    required this.color,
    required this.size,
    required this.life,
    required this.decay,
  });
}

/// Confetti painter for success celebrations
class ConfettiPainter extends CustomPainter {
  final double animationValue;
  final List<Color> colors;
  final int particleCount;
  final List<_ConfettiParticle> _particles;

  ConfettiPainter({
    required this.animationValue,
    required this.colors,
    this.particleCount = 30,
  }) : _particles = List.generate(
          30,
          (i) => _ConfettiParticle(
            x: math.Random(42).nextDouble(),
            speed: 0.5 + math.Random(42).nextDouble() * 0.5,
            angle: math.Random(42).nextDouble() * math.pi * 2,
            size: 4 + math.Random(42).nextDouble() * 4,
          ),
        );

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _particles.length; i++) {
      final p = _particles[i];
      final progress = (animationValue * p.speed) % 1.0;
      final y = -20 + progress * (size.height + 40);
      final x =
          p.x * size.width + math.sin(progress * math.pi * 4 + p.angle) * 20;
      final rotation = progress * math.pi * 4;

      final opacity = progress < 0.8 ? 1.0 : (1.0 - progress) / 0.2;
      final color = colors[i % colors.length].withValues(alpha: opacity);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rotation);

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero, width: p.size, height: p.size * 0.6),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class _ConfettiParticle {
  final double x;
  final double speed;
  final double angle;
  final double size;

  _ConfettiParticle({
    required this.x,
    required this.speed,
    required this.angle,
    required this.size,
  });
}

/// Wave animation painter for audio/music visualizations
class WavePainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final int barCount;
  final double maxHeight;

  WavePainter({
    required this.animationValue,
    required this.color,
    this.barCount = 5,
    this.maxHeight = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (barCount * 2 - 1);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < barCount; i++) {
      final phase = (animationValue + i / barCount) * 2 * math.pi;
      final height = (0.3 + 0.7 * (0.5 + 0.5 * math.sin(phase))) * maxHeight;
      final x = i * barWidth * 2;
      final y = (size.height - height) / 2;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, height),
        Radius.circular(barWidth / 2),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
