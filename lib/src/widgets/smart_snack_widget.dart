import 'dart:ui';
import 'package:flutter/material.dart';
import '../controller.dart';
import '../enums.dart';
import '../theme/smart_snack_colors.dart';
import '../theme/smart_snack_theme.dart';
import '../animations/smart_snack_animations.dart';
import 'smart_snack_components.dart';

/// The main SmartSnack widget that renders notifications.
class SmartSnackWidget extends StatefulWidget {
  final SmartSnackController controller;

  const SmartSnackWidget({super.key, required this.controller});

  @override
  State<SmartSnackWidget> createState() => _SmartSnackWidgetState();
}

class _SmartSnackWidgetState extends State<SmartSnackWidget>
    with TickerProviderStateMixin {
  SmartSnackRequest? _currentRequest;
  bool _isVisible = false;

  // Animation controllers
  late AnimationController _mainController;
  late AnimationController _borderController;
  late AnimationController _iconController;
  late AnimationController _shimmerController;
  late AnimationController _pulseController;

  // Animations
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  // Drag state
  double _dragOffset = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _initAnimationControllers();
    widget.controller.currentSnack.addListener(_handleSnackChange);
  }

  void _initAnimationControllers() {
    // Main animation controller for entrance/exit
    _mainController = AnimationController(
      vsync: this,
      duration: SmartSnackDurations.spring,
    );

    // Border animation for loading state
    _borderController = AnimationController(
      vsync: this,
      duration: SmartSnackDurations.loadingCycle,
    );

    // Icon animation
    _iconController = AnimationController(
      vsync: this,
      duration: SmartSnackDurations.normal,
    );

    // Shimmer animation
    _shimmerController = AnimationController(
      vsync: this,
      duration: SmartSnackDurations.shimmerCycle,
    );

    // Pulse animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Setup animations
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: SmartSnackCurves.springIn,
      ),
    );

    _slideAnimation = Tween<double>(begin: -50, end: 0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: SmartSnackCurves.overshoot,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.currentSnack.removeListener(_handleSnackChange);
    _mainController.dispose();
    _borderController.dispose();
    _iconController.dispose();
    _shimmerController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleSnackChange() {
    final newValue = widget.controller.currentSnack.value;

    if (newValue != null) {
      setState(() {
        _currentRequest = newValue;
        _isVisible = true;
      });

      // Start animations
      _mainController.forward(from: 0);
      _iconController.forward(from: 0);

      // Handle loading-specific animations
      if (newValue.style == SmartSnackStyle.loading) {
        _borderController.repeat();
        _shimmerController.repeat();
      } else {
        _borderController.stop();
        _borderController.reset();
        _shimmerController.stop();
        _shimmerController.reset();
      }

      // Pulse animation for success
      if (newValue.style == SmartSnackStyle.success) {
        _pulseController.forward(from: 0);
      }
    } else {
      // Exit animation
      _mainController.reverse().then((_) {
        if (mounted) {
          setState(() {
            _isVisible = false;
            _currentRequest = null;
          });
        }
      });

      _borderController.stop();
      _borderController.reset();
      _shimmerController.stop();
      _shimmerController.reset();
    }
  }

  Color _getAccentColor() {
    if (_currentRequest == null) return SmartSnackColors.neutral400;
    if (_currentRequest!.accentColor != null) {
      return _currentRequest!.accentColor!;
    }

    switch (_currentRequest!.style) {
      case SmartSnackStyle.success:
        return SmartSnackColors.success;
      case SmartSnackStyle.error:
        return SmartSnackColors.error;
      case SmartSnackStyle.warning:
        return SmartSnackColors.warning;
      case SmartSnackStyle.info:
        return SmartSnackColors.info;
      case SmartSnackStyle.loading:
        return SmartSnackColors.loading;
      case SmartSnackStyle.minimal:
        return SmartSnackColors.neutral400;
      case SmartSnackStyle.glass:
        return SmartSnackColors.textPrimary;
      case SmartSnackStyle.gradient:
        return SmartSnackColors.premiumGradient.first;
      case SmartSnackStyle.compact:
        return SmartSnackColors.neutral300;
      case SmartSnackStyle.banner:
        return SmartSnackColors.info;
      case SmartSnackStyle.alert:
        return SmartSnackColors.error;
      case SmartSnackStyle.custom:
        return SmartSnackColors.textPrimary;
    }
  }

  Color _getBackgroundColor() {
    if (_currentRequest?.backgroundColor != null) {
      return _currentRequest!.backgroundColor!;
    }

    switch (_currentRequest?.style) {
      case SmartSnackStyle.glass:
        return Colors.black.withValues(alpha: 0.7);
      case SmartSnackStyle.gradient:
        return Colors.transparent;
      case SmartSnackStyle.minimal:
        return SmartSnackColors.neutral800;
      case SmartSnackStyle.compact:
        return SmartSnackColors.neutral900;
      case SmartSnackStyle.banner:
        return SmartSnackColors.backgroundDark;
      case SmartSnackStyle.alert:
        return const Color(0xFF2D1A1A); // Dark red tint
      default:
        return SmartSnackColors.backgroundDark;
    }
  }

  List<Color> _getGradientColors() {
    if (_currentRequest?.gradientColors != null) {
      return _currentRequest!.gradientColors!;
    }
    if (_currentRequest?.style == SmartSnackStyle.gradient) {
      return SmartSnackColors.premiumGradient;
    }
    if (_currentRequest?.style == SmartSnackStyle.alert) {
      return [const Color(0xFF991B1B), const Color(0xFFDC2626)];
    }
    return [_getBackgroundColor(), _getBackgroundColor()];
  }

  double _getHeight() {
    // Compact style is always short
    if (_currentRequest?.style == SmartSnackStyle.compact) {
      return SmartSnackSpacing.heightCompact;
    }

    if (_currentRequest?.expanded == true) {
      return _currentRequest?.expandedHeight ?? SmartSnackSpacing.heightLarge;
    }

    // Calculate height based on content
    final hasActions = _currentRequest?.actions?.isNotEmpty == true;
    final hasProgress = _currentRequest?.progress != null;
    final hasSubtitle = _currentRequest?.subtitle != null;

    if (hasActions && hasProgress) {
      return SmartSnackSpacing.heightLarge;
    }
    if (hasActions) {
      return SmartSnackSpacing.heightExpanded;
    }
    if (hasProgress) {
      return SmartSnackSpacing.heightDefault + 16;
    }
    if (hasSubtitle) {
      return SmartSnackSpacing.heightDefault + 8;
    }
    return SmartSnackSpacing.heightDefault;
  }

  double _getBorderRadius() {
    return _currentRequest?.borderRadius ??
        SmartSnackSpacing.borderRadiusDefault;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTop = _currentRequest?.position != SmartSnackPosition.bottom;
    final topPadding = mediaQuery.padding.top;

    // Semantic label for accessibility
    final semanticLabel = _buildSemanticLabel();

    return Positioned(
      top: isTop ? SmartSnackSpacing.topOffset + topPadding : null,
      bottom: !isTop ? SmartSnackSpacing.bottomOffset : null,
      left: 0,
      right: 0,
      child: Semantics(
        label: semanticLabel,
        liveRegion: true, // Announce to screen readers
        container: true,
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _mainController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnimation.value + _dragOffset),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: child,
                  ),
                ),
              );
            },
            child: Center(
              child: _buildSnackContainer(context),
            ),
          ),
        ),
      ),
    );
  }

  String _buildSemanticLabel() {
    if (_currentRequest == null) return '';

    final styleLabel = switch (_currentRequest!.style) {
      SmartSnackStyle.success => 'Success',
      SmartSnackStyle.error => 'Error',
      SmartSnackStyle.warning => 'Warning',
      SmartSnackStyle.info => 'Information',
      SmartSnackStyle.loading => 'Loading',
      _ => 'Notification',
    };

    final title = _currentRequest!.title;
    final subtitle = _currentRequest!.subtitle;

    if (subtitle != null) {
      return '$styleLabel notification: $title. $subtitle';
    }
    return '$styleLabel notification: $title';
  }

  Widget _buildSnackContainer(BuildContext context) {
    if (_currentRequest == null && !_isVisible) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final width = screenWidth * SmartSnackSpacing.maxWidthRatio;
    final height = _getHeight();
    final borderRadius = _getBorderRadius();
    final isLoading = _currentRequest?.style == SmartSnackStyle.loading;
    final isGlass = _currentRequest?.style == SmartSnackStyle.glass ||
        _currentRequest?.enableBlur == true;
    final isGradient = _currentRequest?.style == SmartSnackStyle.gradient;

    return GestureDetector(
      onTap: () {
        _currentRequest?.onTap?.call();
      },
      onVerticalDragStart: (_) {
        setState(() => _isDragging = true);
      },
      onVerticalDragUpdate: (details) {
        final direction =
            _currentRequest?.dismissDirection ?? SmartSnackDismissDirection.up;
        if (direction == SmartSnackDismissDirection.none) return;

        setState(() {
          if (direction == SmartSnackDismissDirection.up ||
              direction == SmartSnackDismissDirection.vertical) {
            if (details.delta.dy < 0) {
              _dragOffset += details.delta.dy;
            }
          }
          if (direction == SmartSnackDismissDirection.down ||
              direction == SmartSnackDismissDirection.vertical) {
            if (details.delta.dy > 0) {
              _dragOffset += details.delta.dy;
            }
          }
        });
      },
      onVerticalDragEnd: (details) {
        setState(() => _isDragging = false);

        if (_dragOffset.abs() > 50 ||
            (details.primaryVelocity?.abs() ?? 0) > 500) {
          widget.controller.dismiss();
        }

        setState(() => _dragOffset = 0);
      },
      child: AnimatedContainer(
        duration: _isDragging ? Duration.zero : SmartSnackDurations.normal,
        curve: SmartSnackCurves.smoothOut,
        width: _isVisible ? width : 0,
        height: _isVisible ? height : 0,
        child: AnimatedBuilder(
          animation: _borderController,
          builder: (context, child) {
            return CustomPaint(
              foregroundPainter: isLoading
                  ? AnimatedGradientBorderPainter(
                      animationValue: _borderController.value,
                      borderRadius: borderRadius,
                      colors: _currentRequest?.loadingIndicatorColors ??
                          SmartSnackColors.loadingGradient,
                      strokeWidth: 2.5,
                      glowIntensity: 0.5,
                    )
                  : null,
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: isGradient
                  ? LinearGradient(
                      colors: _getGradientColors(),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isGradient ? null : _getBackgroundColor(),
              borderRadius: BorderRadius.circular(borderRadius),
              border: (!isLoading)
                  ? Border.all(
                      color: _currentRequest?.borderColor ??
                          SmartSnackColors.glassBorder,
                      width: _currentRequest?.borderWidth ?? 0.5,
                    )
                  : null,
              boxShadow: _currentRequest?.shadows ??
                  [
                    BoxShadow(
                      color: _currentRequest?.enableGlow == true
                          ? _getAccentColor().withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.4),
                      blurRadius: 24,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: isGlass
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _currentRequest?.blurIntensity ?? 20,
                        sigmaY: _currentRequest?.blurIntensity ?? 20,
                      ),
                      child: _buildContent(),
                    )
                  : _buildContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_currentRequest == null) return const SizedBox.shrink();

    final hasActions = _currentRequest!.actions?.isNotEmpty == true;
    final hasProgress = _currentRequest!.progress != null;

    return Directionality(
      textDirection: _currentRequest!.textDirection ?? TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SmartSnackSpacing.lg,
          vertical: SmartSnackSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                textDirection: _currentRequest!.textDirection,
                children: [
                  // Leading
                  _buildLeading(),
                  const SizedBox(width: SmartSnackSpacing.md),

                  // Body
                  Expanded(child: _buildBody()),

                  // Trailing
                  if (_currentRequest!.trailing != null) ...[
                    const SizedBox(width: SmartSnackSpacing.md),
                    _currentRequest!.trailing!,
                  ],
                ],
              ),
            ),

            // Progress bar
            if (hasProgress) ...[
              const SizedBox(height: SmartSnackSpacing.sm),
              GradientProgressBar(
                progress: _currentRequest!.progress!,
                gradientColors: [
                  _getAccentColor(),
                  _getAccentColor().withValues(alpha: 0.7)
                ],
                height: 3,
              ),
            ],

            // Actions
            if (hasActions) ...[
              const SizedBox(height: SmartSnackSpacing.sm),
              _buildActions(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLeading() {
    if (_currentRequest!.leading != null) {
      return SizedBox(
        width: SmartSnackSpacing.iconContainerSize,
        height: SmartSnackSpacing.iconContainerSize,
        child: Center(child: _currentRequest!.leading!),
      );
    }

    return _buildDefaultIcon();
  }

  Widget _buildDefaultIcon() {
    final accent = _getAccentColor();

    switch (_currentRequest!.style) {
      case SmartSnackStyle.success:
        return GlowingIconContainer(
          glowColor: accent,
          child: AnimatedCheckmark(
            color: accent,
            size: 22,
          ),
        );

      case SmartSnackStyle.error:
        return GlowingIconContainer(
          glowColor: accent,
          child: AnimatedXMark(
            color: accent,
            size: 22,
          ),
        );

      case SmartSnackStyle.warning:
        return GlowingIconContainer(
          glowColor: accent,
          child: AnimatedSmartIcon(
            icon: Icons.warning_amber_rounded,
            color: accent,
            size: 24,
          ),
        );

      case SmartSnackStyle.info:
        return GlowingIconContainer(
          glowColor: accent,
          child: AnimatedSmartIcon(
            icon: Icons.info_outline_rounded,
            color: accent,
            size: 24,
          ),
        );

      case SmartSnackStyle.loading:
        return SizedBox(
          width: SmartSnackSpacing.iconContainerSize,
          height: SmartSnackSpacing.iconContainerSize,
          child: GradientCircularProgress(
            indeterminate: true,
            gradientColors: _currentRequest?.loadingIndicatorColors ??
                SmartSnackColors.loadingGradient,
            size: 28,
            strokeWidth: 3,
          ),
        );

      case SmartSnackStyle.minimal:
        return const SizedBox.shrink();

      case SmartSnackStyle.compact:
        return const SizedBox.shrink();

      case SmartSnackStyle.banner:
        return GlowingIconContainer(
          glowColor: accent,
          child: AnimatedSmartIcon(
            icon: Icons.campaign_rounded,
            color: accent,
            size: 24,
          ),
        );

      case SmartSnackStyle.alert:
        return GlowingIconContainer(
          glowColor: accent,
          child: AnimatedSmartIcon(
            icon: Icons.error_rounded,
            color: accent,
            size: 24,
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBody() {
    if (_currentRequest!.bodyWidget != null) {
      return _currentRequest!.bodyWidget!;
    }

    final hasSubtitle = _currentRequest!.subtitle != null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _currentRequest!.title,
          style: _currentRequest!.titleTextStyle ??
              (hasSubtitle
                  ? SmartSnackTypography.titleCompact
                  : SmartSnackTypography.title),
          maxLines: hasSubtitle ? 1 : 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (hasSubtitle) ...[
          const SizedBox(height: 2),
          Text(
            _currentRequest!.subtitle!,
            style: _currentRequest!.subtitleTextStyle ??
                SmartSnackTypography.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (_currentRequest!.showProgressText &&
            _currentRequest!.progress != null) ...[
          const SizedBox(height: 4),
          Text(
            '${(_currentRequest!.progress! * 100).toInt()}%',
            style: SmartSnackTypography.caption.copyWith(
              color: _getAccentColor(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActions() {
    if (_currentRequest!.actions == null) return const SizedBox.shrink();

    return Wrap(
      alignment: WrapAlignment.end,
      spacing: SmartSnackSpacing.sm,
      runSpacing: SmartSnackSpacing.xs,
      children: _currentRequest!.actions!.map((action) {
        return _SmartSnackActionButton(
          action: action,
          onDismiss: () => widget.controller.dismiss(),
        );
      }).toList(),
    );
  }
}

class _SmartSnackActionButton extends StatelessWidget {
  final SmartSnackAction action;
  final VoidCallback onDismiss;

  const _SmartSnackActionButton({
    required this.action,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          action.onPressed();
          if (action.dismissOnTap) {
            onDismiss();
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SmartSnackSpacing.md,
            vertical: SmartSnackSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: action.backgroundColor ?? SmartSnackColors.neutral700,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (action.icon != null) ...[
                Icon(
                  action.icon,
                  size: 16,
                  color: action.textColor ?? SmartSnackColors.info,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                action.label,
                style: SmartSnackTypography.action.copyWith(
                  color: action.textColor ?? SmartSnackColors.info,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
