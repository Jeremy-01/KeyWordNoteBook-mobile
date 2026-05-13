// 设置页面
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../data/providers/providers.dart';
import '../../data/providers/auth_provider.dart';
import 'profile_screen.dart';
import 'change_password_screen.dart';
import 'terms_screen.dart';
import 'privacy_screen.dart';
import '../import_export/export_screen.dart';
import '../import_export/import_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _showLogoutConfirmation = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _SettingsSection(
            title: '账户',
            children: [
              _SettingsItem(
                icon: Icons.person,
                title: '个人信息',
                subtitle: authState.userInfo?.email ?? '已登录',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  );
                },
              ),
              _SettingsItem(
                icon: Icons.lock,
                title: '修改密码',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
                  );
                },
              ),
              _SettingsItem(
                icon: Icons.fingerprint,
                title: '生物识别',
                subtitle: '使用指纹或面容快速解锁',
                trailing: Switch(
                  value: settings.biometricEnabled,
                  onChanged: (value) async {
                    final notifier = ref.read(settingsProvider.notifier);
                    if (!value) {
                      await notifier.setBiometricEnabled(false);
                      return;
                    }

                    final biometricService = ref.read(biometricServiceProvider);
                    final isSupported = await biometricService.isDeviceSupported();
                    final biometrics = await biometricService.getAvailableBiometrics();

                    if (!context.mounted) return;

                    if (!isSupported || biometrics.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('当前设备未配置可用的生物识别能力')),
                      );
                      await notifier.setBiometricEnabled(false);
                      return;
                    }

                    final authenticated = await biometricService.authenticate(
                      reason: '验证身份以启用生物识别解锁',
                      biometricOnly: true,
                    );

                    if (!context.mounted) return;

                    if (!authenticated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('生物识别验证未通过，未启用该功能')),
                      );
                      await notifier.setBiometricEnabled(false);
                      return;
                    }

                    await notifier.setBiometricEnabled(true);
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('已启用生物识别解锁')),
                    );
                  },
                ),
              ),
            ],
          ),
          _SettingsSection(
            title: '同步',
            children: [
              _SettingsItem(
                icon: Icons.sync,
                title: '自动同步',
                trailing: Switch(
                  value: settings.autoSyncEnabled,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).toggleAutoSync();
                  },
                ),
              ),
              _SettingsItem(
                icon: Icons.wifi,
                title: '仅在 Wi-Fi 下同步',
                trailing: Switch(
                  value: settings.wifiOnlySync,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).toggleWifiOnlySync();
                  },
                ),
              ),
            ],
          ),
          _SettingsSection(
            title: '安全',
            children: [
              _SettingsItem(
                icon: Icons.timer,
                title: '自动锁定',
                subtitle: '${settings.autoLockMinutes} 分钟无操作后',
                onTap: () {
                  _showAutoLockPicker(context, ref);
                },
              ),
              _SettingsItem(
                icon: Icons.visibility_off,
                title: '隐藏密码',
                trailing: Switch(
                  value: settings.hidePasswords,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).toggleHidePasswords();
                  },
                ),
              ),
            ],
          ),
          _SettingsSection(
            title: '数据管理',
            children: [
              _SettingsItem(
                icon: Icons.file_upload,
                title: '导出数据',
                subtitle: '导出密码为 CSV 或加密备份',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ExportScreen()),
                  );
                },
              ),
              _SettingsItem(
                icon: Icons.file_download,
                title: '导入数据',
                subtitle: '从 CSV 或备份文件导入',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ImportScreen()),
                  );
                },
              ),
            ],
          ),
          _SettingsSection(
            title: '关于',
            children: [
                const _SettingsItem(
                icon: Icons.info,
                title: '版本',
                subtitle: '${AppConstants.appName} ${AppConstants.appVersion}',
              ),
              _SettingsItem(
                icon: Icons.description,
                title: '用户协议',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const TermsScreen()),
                  );
                },
              ),
              _SettingsItem(
                icon: Icons.privacy_tip,
                title: '隐私政策',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showLogoutConfirmation = !_showLogoutConfirmation;
                    });
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text('退出登录', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                if (_showLogoutConfirmation) ...[
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            '确定要退出登录吗？',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _showLogoutConfirmation = false;
                                  });
                                },
                                child: const Text('取消'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    _showLogoutConfirmation = false;
                                  });
                                  await ref.read(authProvider.notifier).logout();
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text('退出'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showAutoLockPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('自动锁定时间'),
        content: RadioGroup<int>(
          groupValue: ref.read(settingsProvider).autoLockMinutes,
          onChanged: (value) {
            if (value == null) {
              return;
            }
            ref.read(settingsProvider.notifier).setAutoLockDuration(value);
            Navigator.pop(context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [1, 5, 10, 15].map((minutes) {
              return RadioListTile<int>(
                title: Text('$minutes 分钟'),
                value: minutes,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}
