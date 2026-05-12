import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';
import 'data/providers/auth_provider.dart';

/// 应用根组件
class KeyBookApp extends ConsumerWidget {
  const KeyBookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听认证状态
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: '密码本',
      debugShowCheckedModeBanner: false,
      // 浅色主题
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // 深色主题
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // 根据认证状态决定显示登录页还是主页
      home: switch (authState.status) {
        AuthStatus.authenticated => const HomeScreen(),
        AuthStatus.loading || AuthStatus.initial => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        _ => const LoginScreen(),
      },
    );
  }
}
