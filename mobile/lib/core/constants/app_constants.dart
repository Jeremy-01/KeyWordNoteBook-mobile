import 'package:flutter/foundation.dart';

/// 应用常量
class AppConstants {
  AppConstants._();

  /// 应用名称
  static const String appName = 'KeyWordNoteBook';

  static const String appTagline = '你的加密密码库';

  static const String appDescription = '端到端加密、生物识别解锁与多端同步。';

  /// 应用版本
  static const String appVersion = '2.0.0';

  /// 调试模式
  static bool get debug => kDebugMode;

  static const String defaultApiBaseUrl = 'http://localhost:8000/api/v1';

  /// API 基础地址
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: defaultApiBaseUrl,
  );

  /// 数据库名称
  static const String databaseName = 'keybook.db';

  /// 数据库版本
  static const int databaseVersion = 1;
}
