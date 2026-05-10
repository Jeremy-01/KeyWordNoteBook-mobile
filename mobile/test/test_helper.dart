/// 测试辅助工具
import 'package:flutter_test/flutter_test.dart';

/// 设置测试环境
void setupTestEnvironment() {
  TestWidgetsFlutterBinding.ensureInitialized();
}

/// 异步等待
Future<void> wait({int milliseconds = 100}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
