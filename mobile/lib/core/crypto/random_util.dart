/// 随机数生成工具
library;

import 'dart:math';
import 'dart:typed_data';

/// 随机数工具
class RandomUtil {
  RandomUtil._();

  /// 生成随机字节
  static Uint8List generateBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
      List.generate(length, (_) => random.nextInt(256)),
    );
  }

  /// 生成加密盐（16 字节）
  static Uint8List generateEncryptionSalt() => generateBytes(16);

  /// 生成 HMAC 盐（32 字节）
  static Uint8List generateHmacSalt() => generateBytes(32);

  /// 生成随机字符串
  static String generateString(int length, {String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'}) {
    final random = Random.secure();
    return List.generate(length, (_) => chars[random.nextInt(chars.length)]).join();
  }
}
