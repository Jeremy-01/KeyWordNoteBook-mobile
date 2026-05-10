/// 密钥派生工具
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// 密钥派生工具类
class KeyDerivation {
  KeyDerivation._();

  /// 默认迭代次数
  static const int defaultIterations = 100000;

  /// PBKDF2 密钥派生
  ///
  /// [password] 密码
  /// [salt] 盐值
  /// [iterations] 迭代次数
  /// [keyLength] 输出密钥长度（字节）
  static Uint8List pbkdf2({
    required String password,
    required Uint8List salt,
    int iterations = defaultIterations,
    required int keyLength,
  }) {
    final params = Pbkdf2Parameters(salt, iterations, keyLength);
    final derivator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
      ..init(params);

    return derivator.process(Uint8List.fromList(utf8.encode(password)));
  }

  /// 派生 AES-256 密钥
  static Uint8List deriveAesKey(String password, Uint8List salt) {
    return pbkdf2(
      password: password,
      salt: salt,
      keyLength: 32, // AES-256
    );
  }

  /// 派生 HMAC 密钥
  static Uint8List deriveHmacKey(String password, Uint8List salt) {
    return pbkdf2(
      password: password,
      salt: salt,
      keyLength: 16, // 128 位
    );
  }
}
