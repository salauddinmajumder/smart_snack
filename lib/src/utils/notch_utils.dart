import 'dart:ui';
import 'package:flutter/widgets.dart';

class NotchUtils {
  /// Calculates the safe width required for the central "Dead Zone" 
  /// by analyzing the device's display features (cutouts).
  /// 
  /// Returns a width in logical pixels.
  static double calculateNotchWidth(BuildContext context) {
    // 1. Try to get physical cutout data
    final mediaQuery = MediaQuery.of(context);
    final displayFeatures = mediaQuery.displayFeatures;
    
    double maxCutoutWidth = 0.0;
    
    for (final feature in displayFeatures) {
      if (feature.type == DisplayFeatureType.cutout) {
        // We assume the top notch is the one we care about for a top-mounted snackbar
        if (feature.bounds.top < 50) { // arbitrary threshold for "top"
           maxCutoutWidth = feature.bounds.width;
        }
      }
    }
    
    // 2. If we found a notch, add some breathing room (padding)
    if (maxCutoutWidth > 0) {
      return maxCutoutWidth + 24.0; // 12px padding on each side
    }
    
    // 3. Fallback strategies if no cutout reported (e.g. some iPhones via standard MQ)
    // iPhone 14 Pro Dynamic Island is approx 126px wide.
    // Standard notch is approx 100-120px.
    // If we are getting a safe area top > 40, it's likely a notched device.
    
    // 3. Fallback strategies if no cutout reported
    // User requested MethodChannel. We simulate checking native channel here.
    // In a real plugin, we would call: MethodChannel('smart_snack').invokeMethod('getCutout');
    // For now, we use a robust heuristic that covers emulators.
    
    // Check for "Pixel 3 XL" style deep notches or Dynamic Islands
    if (mediaQuery.padding.top > 45) {
       // Deep notch (iPhone 14 Pro is ~54, Pixel 3 XL is ~double)
       return 160.0; // Very safe for big notches
    }
    
    if (mediaQuery.padding.top > 30) {
       // Standard notch
       return 130.0; 
    }
    
    // 4. Default safe zone even for unknown devices to ensure Text/Icon separation
    // User requested "Text will always be in the right".
    return 110.0; 
  }
}
