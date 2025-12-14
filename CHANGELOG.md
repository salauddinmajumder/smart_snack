# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-12-14

### Fixed
- Removed deprecated `authors` field from pubspec.yaml
- Fixed deprecated `withOpacity` calls replaced with `withValues(alpha:)`
- Removed unnecessary import of `package:flutter/physics.dart`
- Added `uses-material-design: true` to fix Material Icons display

### Added
- 18 beautiful screenshots showcasing all notification styles
- Comprehensive screenshot descriptions in pubspec.yaml

## [1.0.0] - 2025-12-14

### 🎉 Initial Release

A beautiful, feature-rich Dynamic Island-style notification system for Flutter.

### Added

#### Core Features
- **9 Notification Styles**: success, error, warning, info, loading, custom, minimal, glass, gradient, compact, banner, alert
- **Smart Queue System**: Priority-based queue management (low, normal, high, urgent, critical)
- **Haptic Feedback**: 10 haptic patterns including success, warning, error, notification
- **Swipe to Dismiss**: 8 dismiss directions with customizable gestures

#### Visual Features
- **Glass Morphism**: Frosted glass effect with customizable blur intensity
- **Gradient Backgrounds**: Pre-built and custom gradient support
- **Animated Icons**: AnimatedCheckmark, AnimatedXMark, and more
- **Glow Effects**: Customizable accent glow on icons
- **Premium Color System**: Carefully crafted semantic colors

#### Animation System
- **Spring Physics**: Natural bouncy animations
- **10 Animation Styles**: spring, slide, fade, scale, slideLeft, slideRight, zoom, bounce, elastic, none
- **Animated Gradient Border**: Loading state with rotating gradient
- **Icon Animations**: bounce, fade, rotate, pulse, shake, flip

#### Customization
- **Full Styling Control**: Colors, typography, borders, shadows
- **Action Buttons**: Multiple actions with icons
- **Progress Indicators**: Linear and circular with gradients
- **Custom Widgets**: Leading, trailing, and body widgets
- **RTL Support**: Full right-to-left language support

#### Convenience Methods
- `SmartSnack.success()` - Success notifications
- `SmartSnack.error()` - Error notifications
- `SmartSnack.warning()` - Warning notifications
- `SmartSnack.info()` - Info notifications
- `SmartSnack.loading()` - Loading state
- `SmartSnack.glass()` - Glass morphism style
- `SmartSnack.gradient()` - Gradient background
- `SmartSnack.progress()` - Progress indicator
- `SmartSnack.compact()` - Minimal pill style
- `SmartSnack.banner()` - Full-width banner
- `SmartSnack.alert()` - High-priority alert
- `SmartSnack.custom()` - Custom icon
- `SmartSnack.withImage()` - Image notification
- `SmartSnack.avatar()` - Avatar with status
- `SmartSnack.countdown()` - Countdown timer
- `SmartSnack.doNotDisturb()` - DND mode

#### Accessibility
- **Screen Reader Support**: Semantic labels and live regions
- **RTL Support**: Proper text direction handling
- **High Contrast**: Carefully chosen color contrasts

#### Developer Experience
- **Comprehensive API**: Well-documented methods and properties
- **Type Safety**: Full Dart null safety support
- **Example App**: Complete showcase with all features

### Dependencies
- Flutter SDK >=3.0.0

---

## [Unreleased]

### Planned
- Sound effects support
- Custom animation curves API
- Notification grouping
- Persistent notifications
- Notification history
