/// 表单验证工具
class Validators {
  Validators._();

  static String? required(String? value, [String fieldName = '字段']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName 不能为空';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return '邮箱不能为空';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '密码不能为空';
    }
    if (value.length < 12) {
      return '密码至少需要 12 个字符';
    }
    return null;
  }

  static String? passwordMatch(String? value, String? confirmValue) {
    if (value != confirmValue) {
      return '两次输入的密码不一致';
    }
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    if (!urlRegex.hasMatch(value)) {
      return '请输入有效的网址';
    }
    return null;
  }
}
