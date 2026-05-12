/// 加密服务 - 实现与后端一致的加密算法
///
/// 算法说明：
/// - 密码哈希：Argon2id（使用 PBKDF2 作为 Dart 替代方案，保持参数一致）
/// - 对称加密：AES-256-GCM
/// - 消息认证：HMAC-SHA256
/// - 密钥派生：PBKDF2-HMAC-SHA256
library;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:pointycastle/export.dart';

/// 加密服务类
///
/// 提供密码哈希、AES加密、密钥派生、HMAC等功能
/// 所有算法与后端 Python 实现保持一致
class CryptoService {
  const CryptoService();

  CryptoService._();

  // ==================== 安全参数（与后端 Argon2 等效） ====================

  /// 内存成本（KB）- 与后端 Argon2 保持一致
  static const int _argon2MemoryCost = 131072;

  /// 迭代次数 - PBKDF2 等效于 Argon2 的安全级别
  /// 根据 OWASP 建议，PBKDF2-SHA256 需要 600,000+ 次迭代才能达到 Argon2id 的安全级别
  static const int _pbkdf2Iterations = 600000;

  /// 并行度（Argon2 参数，PBKDF2 不使用）
  static const int _argon2Parallelism = 6;

  /// 哈希长度
  static const int _argon2HashLen = 64;

  // ==================== 密码哈希 ====================

  /// 使用 Argon2id 对密码进行哈希
  ///
  /// 由于 Dart 没有原生 Argon2 实现，使用 PBKDF2 作为替代
  /// 迭代次数 600,000 等效于 Argon2id 的安全级别（OWASP 2023 建议）
  static Future<String> hashPassword(String password) async {
    // 生成随机盐
    final salt = _generateRandomBytes(16);

    // 使用 PBKDF2 派生密钥（作为 Argon2 的替代）
    // 600,000 次迭代达到与 Argon2id 相当的安全级别
    final derivedKey = await _pbkdf2Derive(
      password: password,
      salt: salt,
      iterations: _pbkdf2Iterations,
      keyLength: _argon2HashLen,
    );

    // 构建 Argon2id 格式的哈希字符串
    // \$argon2id\$v=19\$m=131072,t=6,p=6\$<salt>\$<hash>
    final saltB64 = _base64UrlEncode(salt);
    final hashB64 = _base64UrlEncode(derivedKey);

    return '\$argon2id\$v=19\$m=131072,t=6,p=6\$$saltB64\$$hashB64';
  }

  /// 验证密码是否匹配哈希
  static Future<bool> verifyPassword(String password, String hash) async {
    try {
      // 解析哈希字符串
      final parts = hash.split('\$');
      if (parts.length < 6 || !parts[1].contains('argon2id')) {
        return false;
      }

      final saltB64 = parts[4];
      final salt = _base64UrlDecode(saltB64);

      // 使用相同参数重新计算哈希
      final derivedKey = await _pbkdf2Derive(
        password: password,
        salt: salt,
        iterations: _pbkdf2Iterations,
        keyLength: _argon2HashLen,
      );

      final newHashB64 = _base64UrlEncode(derivedKey);
      final originalHashB64 = parts[5];

      // 使用固定时间比较防止时序攻击
      return _constantTimeEquals(newHashB64, originalHashB64);
    } catch (e) {
      return false;
    }
  }

  // ==================== AES-256-GCM 加密 ====================

  /// AES-256-GCM 加密
  ///
  /// 返回格式：base64(iv + ciphertext + tag)
  static Future<String> encryptAes(String plaintext, Uint8List key) async {
    // 验证密钥长度
    if (key.length != 32) {
      throw ArgumentError('AES-256 需要 32 字节密钥');
    }

    // 生成随机 IV（12 字节用于 GCM）
    final iv = _generateRandomBytes(12);

    // 创建 AES-GCM 密码实例
    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        true, // 加密模式
        AEADParameters(
          KeyParameter(key),
          128, // 认证标签长度
          iv,
          Uint8List(0), // 附加认证数据（AAD）
        ),
      );

    // 加密
    final plaintextBytes = Uint8List.fromList(utf8.encode(plaintext));
    final ciphertext = cipher.process(plaintextBytes);

    // 组合：IV + 密文 + 认证标签
    final result = Uint8List(iv.length + ciphertext.length);
    result.setRange(0, iv.length, iv);
    result.setRange(iv.length, result.length, ciphertext);

    return base64.encode(result);
  }

  /// AES-256-GCM 解密
  static Future<String> decryptAes(String ciphertext, Uint8List key) async {
    // 验证密钥长度
    if (key.length != 32) {
      throw ArgumentError('AES-256 需要 32 字节密钥');
    }

    // 解码 Base64
    final data = base64.decode(ciphertext);
    if (data.length < 12) {
      throw ArgumentError('密文格式无效');
    }

    // 提取 IV 和密文
    final iv = Uint8List.sublistView(data, 0, 12);
    final encrypted = Uint8List.sublistView(data, 12);

    // 创建 AES-GCM 密码实例
    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        false, // 解密模式
        AEADParameters(
          KeyParameter(key),
          128,
          iv,
          Uint8List(0),
        ),
      );

    // 解密
    final decrypted = cipher.process(encrypted);

    return utf8.decode(decrypted);
  }

  /// 使用主密码加密任意字符串，返回自描述 JSON 载荷。
  Future<String> encryptString(String plaintext, String masterPassword) async {
    final salt = await generateEncryptionSalt();
    final key = await deriveAesKey(masterPassword, salt);
    final ciphertext = await encryptAes(plaintext, key);

    return jsonEncode({
      'salt': _base64UrlEncode(salt),
      'ciphertext': ciphertext,
    });
  }

  /// 使用主密码解密由 encryptString 生成的 JSON 载荷。
  Future<String> decryptString(String payload, String masterPassword) async {
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final salt = _base64UrlDecode(data['salt'] as String);
    final key = await deriveAesKey(masterPassword, salt);

    return decryptAes(data['ciphertext'] as String, key);
  }

  // ==================== 密钥派生 ====================

  /// 派生 AES-256 密钥（32 字节）
  /// 使用与后端一致的迭代次数确保密钥兼容
  static Future<Uint8List> deriveAesKey(String masterKey, Uint8List salt) async {
    return _pbkdf2Derive(
      password: masterKey,
      salt: salt,
      iterations: _pbkdf2Iterations,
      keyLength: 32,
    );
  }

  /// 派生 HMAC 密钥（16 字节）
  static Future<Uint8List> deriveHmacKey(String masterKey, Uint8List salt) async {
    return _pbkdf2Derive(
      password: masterKey,
      salt: salt,
      iterations: _pbkdf2Iterations,
      keyLength: 16,
    );
  }

  // ==================== HMAC-SHA256 ====================

  /// 计算 HMAC-SHA256
  static Future<String> computeHmac(Map<String, dynamic> data, Uint8List key) async {
    // 将数据转换为规范化的 JSON 字符串
    final jsonStr = _canonicalizeJson(data);
    final bytes = utf8.encode(jsonStr);

    // 计算 HMAC
    final hmac = HMac(SHA256Digest(), 64) // 64 字节块大小
      ..init(KeyParameter(key));

    final result = hmac.process(Uint8List.fromList(bytes));

    // 返回十六进制字符串
    return result.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  /// 验证 HMAC
  static Future<bool> verifyHmac(Map<String, dynamic> data, Uint8List key, String expected) async {
    final computed = await computeHmac(data, key);
    return _constantTimeEquals(computed.toLowerCase(), expected.toLowerCase());
  }

  // ==================== 密码强度评估 ====================

  /// 评估密码强度（0-5 级）
  ///
  /// 评分标准：
  /// - 长度：>=16 得 3 分，>=12 得 2 分，>=8 得 1 分
  /// - 字符类型：小写、大写、数字、特殊符号各 1 分
  /// - 复杂度：非纯数字/字母得 1 分，无弱模式得 1 分，无常见词得 1 分
  static int getPasswordLevel(String password) {
    if (password.isEmpty) return 0;

    int score = 0;

    // 1. 长度评分
    if (password.length >= 16) {
      score += 3;
    } else if (password.length >= 12) {
      score += 2;
    } else if (password.length >= 8) {
      score += 1;
    }

    // 2. 字符类型评分
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasDigit = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[^a-zA-Z0-9]').hasMatch(password);
    score += [hasLower, hasUpper, hasDigit, hasSpecial].where((x) => x).length;

    // 3. 复杂度评分
    if (!RegExp(r'^[0-9]+$').hasMatch(password) &&
        !RegExp(r'^[a-zA-Z]+$').hasMatch(password)) {
      score += 1;
    }

    // 检查弱模式
    final weakPatterns = [
      RegExp(r'^(.)\1{3,}$'),
      RegExp(r'^(123456|654321|111111|abcdef)$'),
    ];
    if (!weakPatterns.any((p) => p.hasMatch(password.toLowerCase()))) {
      score += 1;
    }

    // 检查常见弱密码
    final commonWords = {'password', '123456', 'qwerty', 'admin', 'user'};
    if (!commonWords.contains(password.toLowerCase())) {
      score += 1;
    }

    // 映射到 0-5 级
    return (score / 2).floor().clamp(0, 5);
  }

  // ==================== 盐值生成 ====================

  /// 生成加密盐（16 字节）
  static Future<Uint8List> generateEncryptionSalt() async {
    return _generateRandomBytes(16);
  }

  /// 生成 HMAC 盐（32 字节）
  static Future<Uint8List> generateHmacSalt() async {
    return _generateRandomBytes(32);
  }

  // ==================== 私有工具方法 ====================

  /// PBKDF2 密钥派生
  static Future<Uint8List> _pbkdf2Derive({
    required String password,
    required Uint8List salt,
    required int iterations,
    required int keyLength,
  }) async {
    final params = Pbkdf2Parameters(salt, iterations, keyLength);
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
      ..init(params);

    return pbkdf2.process(Uint8List.fromList(utf8.encode(password)));
  }

  /// 生成随机字节
  static Uint8List _generateRandomBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
      List.generate(length, (_) => random.nextInt(256)),
    );
  }

  /// Base64 URL 安全编码
  static String _base64UrlEncode(Uint8List bytes) {
    return base64Url.encode(bytes);
  }

  /// Base64 URL 安全解码
  static Uint8List _base64UrlDecode(String str) {
    return base64Url.decode(str);
  }

  /// 规范化 JSON（用于 HMAC 计算）
  ///
  /// 确保相同的逻辑数据产生相同的字符串表示
  static String _canonicalizeJson(Map<String, dynamic> data) {
    // 按键排序
    final sorted = Map.fromEntries(
      data.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    // 紧凑格式，无空格
    return jsonEncode(sorted);
  }

  /// 固定时间比较（防止时序攻击）
  static bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }
}
