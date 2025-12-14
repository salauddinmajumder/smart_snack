# SmartSnack 🍿

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Flutter-blue?logo=flutter" alt="Platform"/>
  <img src="https://img.shields.io/badge/Dart-%3E%3D3.0.0-blue?logo=dart" alt="Dart"/>
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen" alt="PRs Welcome"/>
</p>

<p align="center">
  <b>Author:</b> Salauddin Majumder • <a href="mailto:salauddinmajumder01@gmail.com">salauddinmajumder01@gmail.com</a> • <a href="https://salauddin4227.github.io/salauddinmajumder">Portfolio</a> • <a href="https://github.com/salauddin-majumder">GitHub</a>
</p>

<p align="center">
  <b>A beautiful, feature-rich and Highly Customizable Dynamic Island-style notification system for Flutter.</b>
</p>

<p align="center">
  Inspired by iOS Dynamic Island • Premium Animations • Highly Customizable
</p>

---

## ✨ Features

🎨 **Beautiful Design**
- iOS Dynamic Island inspired aesthetics
- Premium color palette with semantic colors
- Glass morphism & gradient effects
- Smooth spring-based animations

⚡ **Smart Queue System**
- Intelligent notification queuing
- Priority-based display (normal, high, urgent)
- Loading → Success/Error transitions
- Update notifications in real-time

🎯 **Multiple Preset Styles**
- Success, Error, Warning, Info
- Loading with animated gradient border
- Glass morphism with blur
- Custom gradient backgrounds
- Minimal style

---

## 🖼️ Screenshots

Add screenshot images to the `screenshots/` folder and reference them in `pubspec.yaml` under the `screenshots` section. Recommended image specs:

- Format: `png` or `jpg`
- Recommended size: 1280×720 (landscape) or 720×1280 (portrait)
- Keep file sizes under 500 KB for faster uploads

Example `pubspec.yaml` snippet:

```yaml
# screenshots:
#   - description: 'SmartSnack success notification (top)'
#     path: screenshots/success.png
#   - description: 'SmartSnack loading state (animated)'
#     path: screenshots/loading.png
```

Steps to add screenshots:

1. Create high-quality images and save them into the `screenshots/` folder.
2. Uncomment and update the `screenshots:` section in `pubspec.yaml` with correct paths.
3. Run `flutter pub publish --dry-run` to validate before publishing.
4. When ready, run `flutter pub publish` to publish the new version.

If you prefer not to upload images during the first publish, keep the `screenshots` section commented — you can add screenshots in a later release.

🛠️ **Highly Customizable**
- Custom icons, colors, and typography
- Action buttons with callbacks
- Progress indicators
- Subtitles and body widgets
- Position (top/bottom)

📳 **Interactive**
- Swipe-to-dismiss gestures
- Haptic feedback support
- Tap callbacks
- Configurable dismiss directions

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  smart_snack: ^1.0.0
```

Then run:
```bash
flutter pub get
```

---

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:smart_snack/smart_snack.dart';

// Success notification
SmartSnack.success(context, title: 'Payment successful!');

// Error notification
SmartSnack.error(context, title: 'Connection failed');

// Warning notification
SmartSnack.warning(context, title: 'Low battery');

// Info notification
SmartSnack.info(context, title: 'New update available');
```

### Loading State

```dart
// Show loading
SmartSnack.loading(context, title: 'Processing...');

// Do your async work
await someAsyncOperation();

// Then show result
SmartSnack.success(context, title: 'Complete!');
// or
SmartSnack.error(context, title: 'Failed');
```

### With Subtitles

```dart
SmartSnack.success(
  context,
  title: 'Payment Received',
  subtitle: '\$50.00 from John',
);
```

---

## 🎨 Styles

### Glass Morphism
```dart
SmartSnack.glass(
  context,
  title: 'AirDrop Received',
  subtitle: 'Photo from nearby iPhone',
);
```

### Gradient Background
```dart
SmartSnack.gradient(
  context,
  title: 'Premium Unlocked! ✨',
  gradientColors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
);
```

### Progress Indicator
```dart
SmartSnack.progress(
  context,
  title: 'Uploading...',
  progress: 0.65,
  showProgressText: true,
);
```

---

## 🔧 Advanced Usage

### Action Buttons

```dart
SmartSnack.info(
  context,
  title: 'File deleted',
  actions: [
    SmartSnackAction(
      label: 'Undo',
      onPressed: () => restoreFile(),
    ),
  ],
);
```

### Custom Notification

```dart
SmartSnack.show(
  context,
  title: 'Now Playing',
  style: SmartSnackStyle.custom,
  leading: ClipRRect(
    borderRadius: BorderRadius.circular(6),
    child: Image.network(albumArt, width: 36, height: 36),
  ),
  bodyWidget: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Song Title', style: TextStyle(color: Colors.white)),
      Text('Artist Name', style: TextStyle(color: Colors.white54)),
    ],
  ),
  trailing: Icon(Icons.music_note, color: Colors.white54),
);
```

### Priority Queue

```dart
// Normal priority (queued)
SmartSnack.info(context, title: 'Normal notification');

// Urgent priority (shows immediately)
SmartSnack.show(
  context,
  title: 'URGENT: Action required!',
  style: SmartSnackStyle.warning,
  priority: SmartSnackPriority.urgent,
);
```

### Bottom Position

```dart
SmartSnack.success(
  context,
  title: 'Saved to favorites',
  position: SmartSnackPosition.bottom,
);
```

### Update Existing Notification

```dart
// Show with ID
SmartSnack.loading(
  context,
  id: 'download',
  title: 'Downloading...',
);

// Update progress
SmartSnack.progress(
  context,
  id: 'download',
  title: 'Downloading...',
  progress: 0.5,
);
```

---

## 📖 API Reference

### SmartSnack Static Methods

| Method | Description |
|--------|-------------|
| `success()` | Green checkmark notification |
| `error()` | Red X mark notification |
| `warning()` | Amber warning notification |
| `info()` | Blue info notification |
| `loading()` | Loading with gradient border |
| `glass()` | Glass morphism style |
| `gradient()` | Gradient background |
| `progress()` | With progress indicator |
| `show()` | Fully customizable |
| `dismiss()` | Dismiss current notification |
| `dismissAll()` | Dismiss all and clear queue |

### SmartSnackStyle

| Style | Description |
|-------|-------------|
| `success` | Green success style |
| `error` | Red error style |
| `warning` | Amber warning style |
| `info` | Blue info style |
| `loading` | Loading with animated border |
| `custom` | Fully customizable |
| `minimal` | Clean minimal style |
| `glass` | Glass morphism with blur |
| `gradient` | Gradient background |

### SmartSnackPosition

| Position | Description |
|----------|-------------|
| `top` | Display at top (default) |
| `bottom` | Display at bottom |

### SmartSnackPriority

| Priority | Description |
|----------|-------------|
| `low` | Queued normally |
| `normal` | Queued normally (default) |
| `high` | Jumps ahead in queue |
| `urgent` | Shows immediately |

### SmartSnackHaptic

| Haptic | Description |
|--------|-------------|
| `light` | Light tap feedback |
| `medium` | Medium feedback |
| `heavy` | Heavy feedback |
| `success` | Double light tap |
| `warning` | Medium tap |
| `error` | Heavy + medium tap |
| `none` | No haptic feedback |

---

## 🎨 Customization

### Custom Colors

```dart
SmartSnack.show(
  context,
  title: 'Custom styled',
  style: SmartSnackStyle.custom,
  backgroundColor: Colors.indigo,
  accentColor: Colors.amber,
  borderColor: Colors.amber.withOpacity(0.3),
);
```

### Custom Typography

```dart
SmartSnack.success(
  context,
  title: 'Styled text',
  titleTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
);
```

### Available Components

The package also exports reusable widgets:

```dart
import 'package:smart_snack/smart_snack.dart';

// Animated checkmark
AnimatedCheckmark(color: Colors.green, size: 24)

// Animated X mark
AnimatedXMark(color: Colors.red, size: 24)

// Gradient progress bar
GradientProgressBar(progress: 0.7)

// Circular progress indicator
GradientCircularProgress(indeterminate: true)

// Status avatar with indicator
StatusAvatar(
  image: NetworkImage(url),
  showStatus: true,
  statusColor: Colors.green,
)
```

---

## 🤝 Contributing

Contributions are welcome! Please read our contributing guidelines before submitting a PR.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

---
---

## 🙏 Acknowledgments

- Inspired by Apple's Dynamic Island
- Built with ❤️ for the Flutter community

---

<p align="center">
  <b>If you like this package, please ⭐ the repo!</b>
</p>
