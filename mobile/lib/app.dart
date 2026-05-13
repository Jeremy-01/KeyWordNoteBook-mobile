import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/security/auto_lock_service.dart';
import 'core/theme/keybook_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/lock_screen.dart';
import 'features/home/home_screen.dart';
import 'data/providers/auth_provider.dart';
import 'data/providers/settings_provider.dart';
import 'shared/widgets/brand_banner.dart';

/// 应用根组件
class KeyBookApp extends ConsumerStatefulWidget {
  const KeyBookApp({super.key});

  @override
  ConsumerState<KeyBookApp> createState() => _KeyBookAppState();
}

class _KeyBookAppState extends ConsumerState<KeyBookApp>
    with WidgetsBindingObserver {
  final _authenticatedNavigatorKey = GlobalKey<NavigatorState>();
  final _unauthenticatedNavigatorKey = GlobalKey<NavigatorState>();
  late final AutoLockService _autoLockService;
  bool _isLocked = false;
  bool _biometricAvailable = false;
  bool _isUnlockingWithBiometric = false;
  bool _didAttemptBiometricForCurrentLock = false;
  String? _lockError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _autoLockService = AutoLockService(onLock: _handleLockRequested);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncLockState(
        ref.read(authProvider),
        ref.read(settingsProvider),
      );
      _refreshBiometricAvailability();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _autoLockService.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated) {
      return;
    }

    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _lock();
      case AppLifecycleState.resumed:
        if (!_isLocked) {
          _autoLockService.resetTimer();
        }
      case AppLifecycleState.detached:
        break;
    }
  }

  void _handleLockRequested() {
    _lock();
  }

  void _lock() {
    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated || _isLocked) {
      return;
    }

    _autoLockService.stop();
    setState(() {
      _isLocked = true;
      _lockError = null;
      _isUnlockingWithBiometric = false;
      _didAttemptBiometricForCurrentLock = false;
    });
    _attemptBiometricUnlock(automatic: true);
  }

  void _unlock() {
    if (!_isLocked) {
      return;
    }

    setState(() {
      _isLocked = false;
      _lockError = null;
      _isUnlockingWithBiometric = false;
      _didAttemptBiometricForCurrentLock = false;
    });
    _autoLockService.unlock();
  }

  Future<void> _refreshBiometricAvailability() async {
    final settings = ref.read(settingsProvider);
    if (!settings.biometricEnabled) {
      if (_biometricAvailable) {
        setState(() {
          _biometricAvailable = false;
        });
      }
      return;
    }

    final biometricService = ref.read(biometricServiceProvider);
    final isSupported = await biometricService.isDeviceSupported();
    final biometrics = await biometricService.getAvailableBiometrics();
    final available = isSupported && biometrics.isNotEmpty;

    if (!mounted || available == _biometricAvailable) {
      return;
    }

    setState(() {
      _biometricAvailable = available;
    });
  }

  void _syncLockState(AuthState authState, SettingsState settings) {
    if (!authState.isAuthenticated) {
      _autoLockService.stop();
      if (_isLocked) {
        setState(() {
          _isLocked = false;
          _lockError = null;
          _isUnlockingWithBiometric = false;
          _didAttemptBiometricForCurrentLock = false;
        });
      }
      return;
    }

    _autoLockService.setLockDuration(
      Duration(minutes: settings.autoLockMinutes),
    );

    if (!_isLocked) {
      _autoLockService.start();
    }
  }

  Future<void> _attemptBiometricUnlock({bool automatic = false}) async {
    final authState = ref.read(authProvider);
    final settings = ref.read(settingsProvider);
    if (!_isLocked ||
        !authState.isAuthenticated ||
        !settings.biometricEnabled ||
        !_biometricAvailable ||
        _isUnlockingWithBiometric) {
      return;
    }

    if (automatic && _didAttemptBiometricForCurrentLock) {
      return;
    }

    if (automatic) {
      _didAttemptBiometricForCurrentLock = true;
    }

    setState(() {
      _isUnlockingWithBiometric = true;
      _lockError = null;
    });

    final biometricService = ref.read(biometricServiceProvider);
    final authenticated = await biometricService.authenticate(
      reason: '验证身份以解锁密码本',
      biometricOnly: true,
    );

    if (!mounted) {
      return;
    }

    if (authenticated) {
      _unlock();
      return;
    }

    setState(() {
      _isUnlockingWithBiometric = false;
      if (!automatic) {
        _lockError = '生物识别验证失败，请重试或输入主密码解锁';
      }
    });
  }

  Future<String?> _submitManualUnlock(String input) async {
    final authState = ref.read(authProvider);
    final savedMasterPassword = authState.masterPassword;

    if (savedMasterPassword == null || savedMasterPassword.isEmpty) {
      return '当前会话缺少主密码，请重新登录';
    }

    if (input == savedMasterPassword) {
      _unlock();
      return null;
    }

    return '主密码错误';
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      _syncLockState(next, ref.read(settingsProvider));
    });
    ref.listen<SettingsState>(settingsProvider, (previous, next) {
      _syncLockState(ref.read(authProvider), next);
      _refreshBiometricAvailability();
    });

    final authState = ref.watch(authProvider);
    final settings = ref.watch(settingsProvider);
    final navigatorKey = authState.isAuthenticated
      ? _authenticatedNavigatorKey
      : _unauthenticatedNavigatorKey;
    final home = authState.isCheckingSession ||
            authState.status == AuthStatus.initial
        ? const _AppBootstrapScreen()
        : authState.isAuthenticated
            ? const HomeScreen()
            : const LoginScreen();

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: KeyBookTheme.light(),
      darkTheme: KeyBookTheme.dark(),
      themeMode: ThemeMode.system,
      home: home,
      builder: (context, child) {
        final content = authState.isAuthenticated
            ? Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (_) {
                  if (!_isLocked) {
                    _autoLockService.resetTimer();
                  }
                },
                child: child ?? const SizedBox.shrink(),
              )
            : child ?? const SizedBox.shrink();

        if (!authState.isAuthenticated || !_isLocked) {
          return content;
        }

        return Stack(
          children: [
            content,
            LockScreen(
              onManualUnlockSubmit: _submitManualUnlock,
              biometricAvailable:
                  settings.biometricEnabled && _biometricAvailable,
              onBiometricUnlock: () => _attemptBiometricUnlock(),
              isUnlocking: _isUnlockingWithBiometric,
              errorMessage: _lockError,
            ),
          ],
        );
      },
    );
  }
}

class _AppBootstrapScreen extends StatelessWidget {
  const _AppBootstrapScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primaryContainer.withValues(alpha: 0.72),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const BrandBanner(
                      subtitle: '与你的桌面端保持一致的安全密码体验',
                      supportingText: '端到端加密、生物识别解锁与多端同步',
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '正在准备你的密码库',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '正在检查本地加密状态与安全会话。',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.68),
                              ),
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
      ),
    );
  }
}
