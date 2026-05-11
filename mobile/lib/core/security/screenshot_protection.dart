import 'dart:io';

class ScreenshotProtection {
  static bool _isEnabled = false;

  static bool get isEnabled => _isEnabled;

  static void enable() {
    if (Platform.isAndroid) {
      _enableAndroidProtection();
    } else if (Platform.isIOS) {
      _enableIOSProtection();
    }
    _isEnabled = true;
  }

  static void disable() {
    _isEnabled = false;
  }

  static void _enableAndroidProtection() {
  }

  static void _enableIOSProtection() {
  }
}
