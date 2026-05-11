import 'package:flutter/material.dart';

class SecurityWarningDialog extends StatelessWidget {
  final String message;
  final VoidCallback onContinue;
  final VoidCallback onExit;

  const SecurityWarningDialog({
    super.key,
    required this.message,
    required this.onContinue,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              '安全警告',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '在可能已 Root 或越狱的设备上使用密码管理器存在安全风险。',
                    style: TextStyle(fontSize: 12, color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onExit,
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: const Text('退出应用'),
        ),
        ElevatedButton(
          onPressed: onContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          child: const Text('继续使用'),
        ),
      ],
    );
  }
}

Future<bool> showSecurityWarningDialog(
  BuildContext context, {
  required String message,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => SecurityWarningDialog(
      message: message,
      onContinue: () => Navigator.of(context).pop(true),
      onExit: () => Navigator.of(context).pop(false),
    ),
  );

  return result ?? false;
}
