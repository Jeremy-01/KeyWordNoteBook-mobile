/// API 端点定义
class ApiEndpoints {
  ApiEndpoints._();

  // 认证
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String currentUser = '/auth/me';

  // 密码本
  static const String keybookItems = '/keybook/items';
  static String keybookItem(String id) => '/keybook/items/$id';

  // 同步
  static const String syncStatus = '/sync/status';
  static const String syncPush = '/sync/push';
  static const String syncPull = '/sync/pull';
}
