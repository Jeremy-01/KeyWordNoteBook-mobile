/// 密码强度评估器
class PasswordStrength {
  PasswordStrength._();

  /// 评估密码强度（0-5 级）
  static int evaluate(String password) {
    if (password.isEmpty) return 0;

    int score = 0;

    // 1. 长度评分（最高 3 分）
    if (password.length >= 16) {
      score += 3;
    } else if (password.length >= 12) {
      score += 2;
    } else if (password.length >= 8) {
      score += 1;
    }

    // 2. 字符类型评分（最高 4 分）
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasDigit = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[^a-zA-Z0-9]').hasMatch(password);
    score += [hasLower, hasUpper, hasDigit, hasSpecial].where((x) => x).length;

    // 3. 复杂度评分（最高 3 分）
    // 3.1 非纯数字/字母
    if (!RegExp(r'^[0-9]+\$').hasMatch(password) &&
        !RegExp(r'^[a-zA-Z]+\$').hasMatch(password)) {
      score += 1;
    }

    // 3.2 无弱模式
    final weakPatterns = [
      RegExp(r'^(.)
{4,}\$'), // 重复字符
      RegExp(r'^123456|654321|111111|abcdef|qwerty\$'),
    ];
    if (!weakPatterns.any((p) => p.hasMatch(password.toLowerCase()))) {
      score += 1;
    }

    // 3.3 无常见弱密码
    final commonWords = {
      'password', '123456', '12345678', 'qwerty', 'abc123',
      'monkey', 'letmein', 'dragon', '111111', 'baseball',
    };
    if (!commonWords.contains(password.toLowerCase())) {
      score += 1;
    }

    // 映射到 0-5 级
    return (score / 2).floor().clamp(0, 5);
  }

  /// 获取强度描述
  static String getDescription(int level) {
    return switch (level) {
      0 => '极弱',
      1 => '弱',
      2 => '一般',
      3 => '良好',
      4 => '强',
      5 => '极强',
      _ => '未知',
    };
  }

  /// 获取强度颜色（用于 UI）
  static int getColorValue(int level) {
    return switch (level) {
      0 => 0xFFE53935, // 红色
      1 => 0xFFFF7043, // 深橙
      2 => 0xFFFFCA28, // 琥珀
      3 => 0xFF66BB6A, // 绿色
      4 => 0xFF43A047, // 深绿
      5 => 0xFF2E7D32, // 墨绿
      _ => 0xFF9E9E9E, // 灰色
    };
  }
}
