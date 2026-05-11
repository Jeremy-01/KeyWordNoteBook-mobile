import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ClipboardUtils {
  static Timer? _clearTimer;
  static const Duration clearDelay = Duration(seconds: 15);

  static Future<void> copyWithAutoClear(
    BuildContext context,
    String text, {
    String label = '内容',
    Duration? delay,
    VoidCallback? onCleared,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));

    _clearTimer?.cancel();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label 已复制，${(delay ?? clearDelay).inSeconds}秒后自动清除'),
        duration: Duration(seconds: ((delay ?? clearDelay).inSeconds).clamp(1, 10)),
        action: SnackBarAction(
          label: '清除',
          onPressed: () {
            clearClipboard();
          },
        ),
      ),
    );

    _clearTimer = Timer(delay ?? clearDelay, () {
      clearClipboard();
      onCleared?.call();
    });
  }

  static Future<void> clearClipboard() async {
    await Clipboard.setData(const ClipboardData(text: ''));
  }

  static void cancelTimer() {
    _clearTimer?.cancel();
    _clearTimer = null;
  }

  static bool get hasPendingClear => _clearTimer?.isActive ?? false;
}
