/// 表单验证工具
class Validators {
  Validators._();

  static const Set<String> _commonPasswords = {
    'password',
    '123456',
    '123456789',
    '12345678',
    '1234567',
    'qwerty',
    'abc123',
    'monkey',
    '1234567890',
    'letmein',
    'trustno1',
    'dragon',
    'baseball',
    'iloveyou',
    'master',
    'sunshine',
    'ashley',
    'football',
    'shadow',
    '123123',
    '654321',
    'superman',
    'qazwsx',
    'michael',
    'password1',
    'password123',
    'welcome',
    'welcome1',
    'admin',
    'login',
  };

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

  static String? password(String? value) => passwordRequired(value);

  static String? passwordRequired(String? value, [String fieldName = '密码']) {
    if (value == null || value.isEmpty) {
      return '$fieldName不能为空';
    }
    return null;
  }

  static String? strongPassword(String? value, {String fieldName = '密码'}) {
    final requiredError = passwordRequired(value, fieldName);
    if (requiredError != null) {
      return requiredError;
    }

    final password = value!;
    if (password.length < 8) {
      return '$fieldName长度至少为 8 个字符';
    }
    if (password.length > 128) {
      return '$fieldName长度不能超过 128 个字符';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return '$fieldName必须包含至少一个小写字母';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return '$fieldName必须包含至少一个大写字母';
    }
    if (!RegExp(r'\d').hasMatch(password)) {
      return '$fieldName必须包含至少一个数字';
    }

    final lowerPassword = password.toLowerCase();
    if (_commonPasswords.contains(lowerPassword)) {
      return '$fieldName太简单，请使用更复杂的密码';
    }

    if (RegExp(r'^(.)\1{4,}$').hasMatch(password)) {
      return '$fieldName包含弱模式，请使用更复杂的密码';
    }

    const weakPrefixes = ['123456', '654321', '111111', 'abcdef'];
    for (final prefix in weakPrefixes) {
      if (lowerPassword.startsWith(prefix)) {
        return '$fieldName包含弱模式，请使用更复杂的密码';
      }
    }

    return null;
  }

  static String? passwordMatch(String? value, String? confirmValue) {
    if (value == null || confirmValue == null) {
      return '两次输入的密码不一致';
    }
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
