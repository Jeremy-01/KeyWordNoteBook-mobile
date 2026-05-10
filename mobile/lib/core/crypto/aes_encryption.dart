/// AES 加密工具类
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// AES-GCM 加密工具
class AesEncryption {
  AesEncryption._();

  /// 密钥长度（AES-256）
  static const int keyLength = 32;

  /// IV 长度（GCM 推荐 12 字节）
  static const int ivLength = 12;

  /// 认证标签长度（位）
  static const int tagLength = 128;

  /// 加密
  ///
  /// [plaintext] 明文
  /// [key] 32 字节密钥
  ///
  /// 返回：base64(iv + ciphertext + tag)
  static String encrypt(String plaintext, Uint8List key) {
    if (key.length != keyLength) {
      throw ArgumentError('AES-256 需要 $keyLength 字节密钥，实际 ${key.length} 字节');
    }

    // 生成随机 IV
    final iv = _generateIV();

    // 创建 GCM 参数
    final params = AEADParameters(
      KeyParameter(key),
      tagLength,
      iv,
      Uint8List(0), // 无 AAD
    );

    // 初始化加密器
    final cipher = GCMBlockCipher(AESEngine())..init(true, params);

    // 加密
    final input = Uint8List.fromList(utf8.encode(plaintext));
    final output = cipher.process(input);

    // 组合：IV + 密文（包含认证标签）
    final result = Uint8List(iv.length + output.length);
    result.setRange(0, iv.length, iv);
    result.setRange(iv.length, result.length, output);

    return base64.encode(result);
  }

  /// 解密
  ///
  /// [ciphertext] base64(iv + ciphertext + tag)
  /// [key] 32 字节密钥
  static String decrypt(String ciphertext, Uint8List key) {
    if (key.length != keyLength) {
      throw ArgumentError('AES-256 需要 $keyLength 字节密钥，实际 ${key.length} 字节');
    }

    // 解码 Base64
    final data = base64.decode(ciphertext);
    if (data.length < ivLength) {
      throw ArgumentError('密文格式无效：长度不足');
    }

    // 提取 IV 和密文
    final iv = Uint8List.sublistView(data, 0, ivLength);
    final encrypted = Uint8List.sublistView(data, ivLength);

    // 创建 GCM 参数
    final params = AEADParameters(
      KeyParameter(key),
      tagLength,
      iv,
      Uint8List(0),
    );

    // 初始化解密器
    final cipher = GCMBlockCipher(AESEngine())..init(false, params);

    // 解密（会自动验证认证标签）
    final decrypted = cipher.process(encrypted);

    return utf8.decode(decrypted);
  }

  /// 生成随机 IV
  static Uint8List _generateIV() {
    final random = SecureRandom('Fortuna')
      ..seed(KeyParameter(Uint8List.fromList(
        List.generate(32, (i) => DateTime.now().microsecond + i),
      )));
    return random.nextBytes(ivLength);
  }
}
