import 'package:flutter/material.dart';

import '../../shared/widgets/app_text_field.dart';

class LockScreen extends StatefulWidget {
  final Future<String?> Function(String password) onManualUnlockSubmit;
  final bool biometricAvailable;
  final VoidCallback? onBiometricUnlock;
  final bool isUnlocking;
  final String? errorMessage;

  const LockScreen({
    super.key,
    required this.onManualUnlockSubmit,
    this.biometricAvailable = false,
    this.onBiometricUnlock,
    this.isUnlocking = false,
    this.errorMessage,
  });

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _passwordController = TextEditingController();
  bool _showManualUnlockForm = false;
  bool _isSubmittingManualUnlock = false;
  String? _manualUnlockError;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitManualUnlock() async {
    if (_isSubmittingManualUnlock) {
      return;
    }

    setState(() {
      _isSubmittingManualUnlock = true;
      _manualUnlockError = null;
    });

    final error = await widget.onManualUnlockSubmit(_passwordController.text);
    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmittingManualUnlock = false;
      _manualUnlockError = error;
    });
  }

  void _showManualUnlockPanel() {
    setState(() {
      _showManualUnlockForm = true;
      _manualUnlockError = null;
      _passwordController.clear();
    });
  }

  void _hideManualUnlockPanel() {
    setState(() {
      _showManualUnlockForm = false;
      _isSubmittingManualUnlock = false;
      _manualUnlockError = null;
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            Icons.lock,
                            size: 48,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          '密码本已锁定',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '请解锁以继续使用',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 48),
                        if (widget.errorMessage != null) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: theme.colorScheme.onErrorContainer,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    widget.errorMessage!,
                                    style: TextStyle(
                                      color: theme.colorScheme.onErrorContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (widget.biometricAvailable &&
                            widget.onBiometricUnlock != null) ...[
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: widget.isUnlocking
                                  ? null
                                  : widget.onBiometricUnlock,
                              icon: widget.isUnlocking
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.fingerprint),
                              label: Text(
                                widget.isUnlocking ? '验证中...' : '使用生物识别解锁',
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (!_showManualUnlockForm)
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: widget.isUnlocking
                                  ? null
                                  : _showManualUnlockPanel,
                              icon: const Icon(Icons.password),
                              label: const Text('输入密码解锁'),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          )
                        else
                          Card(
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '输入主密码解锁',
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '请输入当前会话的主密码以恢复访问。',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.68),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  AppTextField(
                                    controller: _passwordController,
                                    label: '主密码',
                                    hint: '请输入当前主密码',
                                    obscureText: true,
                                    autofocus: true,
                                    errorText: _manualUnlockError,
                                    onChanged: (_) {
                                      if (_manualUnlockError != null) {
                                        setState(() {
                                          _manualUnlockError = null;
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: _isSubmittingManualUnlock
                                            ? null
                                            : _hideManualUnlockPanel,
                                        child: const Text('取消'),
                                      ),
                                      const SizedBox(width: 12),
                                      FilledButton(
                                        onPressed: _isSubmittingManualUnlock
                                            ? null
                                            : _submitManualUnlock,
                                        child: _isSubmittingManualUnlock
                                            ? const SizedBox(
                                                width: 18,
                                                height: 18,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : const Text('解锁'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
