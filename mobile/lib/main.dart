import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// 应用入口函数
void main() {
  // 确保 Flutter 绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 启动应用，使用 ProviderScope 包裹以支持 Riverpod 状态管理
  runApp(
    const ProviderScope(
      child: KeyBookApp(),
    ),
  );
}
