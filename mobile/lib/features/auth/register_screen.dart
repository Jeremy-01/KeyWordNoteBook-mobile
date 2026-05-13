// 注册页面
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/auth_provider.dart';
import '../../shared/widgets/widgets.dart';
import '../../shared/utils/validators.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  void _clearAuthError() {
    if (ref.read(authProvider).error != null) {
      ref.read(authProvider.notifier).clearError();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final authNotifier = ref.read(authProvider.notifier);
    final success = await authNotifier.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.secondaryContainer.withValues(alpha: 0.7),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: LoadingOverlay(
            isLoading: authState.isLoading,
            message: '注册中...',
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('返回登录'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const BrandBanner(
                        compact: true,
                        subtitle: '创建新的安全保险库',
                        supportingText: '主密码仅你自己知晓，请务必妥善保管。',
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  '创建账户',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '注册后将立即进入你的加密密码库。',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.68),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                AppTextField(
                                  controller: _emailController,
                                  label: '邮箱',
                                  hint: '请输入邮箱',
                                  keyboardType: TextInputType.text,
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  validator: Validators.email,
                                  onChanged: (_) => _clearAuthError(),
                                ),
                                const SizedBox(height: 20),
                                AppTextField(
                                  controller: _passwordController,
                                  label: '主密码',
                                  hint: '请输入主密码',
                                  obscureText: _obscurePassword,
                                  prefixIcon: const Icon(Icons.lock_outlined),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  validator: Validators.strongPassword,
                                  onChanged: (_) {
                                    _clearAuthError();
                                    setState(() {});
                                  },
                                ),
                                const SizedBox(height: 8),
                                PasswordStrengthIndicator(
                                  password: _passwordController.text,
                                ),
                                const SizedBox(height: 20),
                                AppTextField(
                                  controller: _confirmController,
                                  label: '确认主密码',
                                  hint: '请再次输入主密码',
                                  obscureText: _obscureConfirm,
                                  prefixIcon: const Icon(Icons.lock_outlined),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureConfirm
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirm = !_obscureConfirm;
                                      });
                                    },
                                  ),
                                  validator: (value) => Validators.passwordMatch(
                                    _passwordController.text,
                                    value,
                                  ),
                                  onChanged: (_) => _clearAuthError(),
                                ),
                                if (authState.error != null) ...[
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.errorContainer,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: theme.colorScheme
                                              .onErrorContainer,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            authState.error!,
                                            style: TextStyle(
                                              color: theme.colorScheme
                                                  .onErrorContainer,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 32),
                                AppButton(
                                  text: '创建并进入密码库',
                                  onPressed: _handleRegister,
                                  isLoading: authState.isLoading,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
