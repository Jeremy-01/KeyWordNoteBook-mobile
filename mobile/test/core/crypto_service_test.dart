/// 加密服务测试 - TDD 方式
/// 先写测试，后实现代码
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/crypto/crypto_service.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('CryptoService - 密码哈希', () {
    test('hashPassword 应该返回非空字符串', () async {
      // ARRANGE
      const password = 'TestP@ss123';

      // ACT
      final hash = await CryptoService.hashPassword(password);

      // ASSERT
      expect(hash, isNotNull);
      expect(hash, isNotEmpty);
      expect(hash, startsWith('\$argon2id\$'));
    });

    test('verifyPassword 应该正确验证正确密码', () async {
      // ARRANGE
      const password = 'TestP@ss123';
      final hash = await CryptoService.hashPassword(password);

      // ACT
      final isValid = await CryptoService.verifyPassword(password, hash);

      // ASSERT
      expect(isValid, isTrue);
    });

    test('verifyPassword 应该拒绝错误密码', () async {
      // ARRANGE
      const password = 'TestP@ss123';
      const wrongPassword = 'WrongP@ss456';
      final hash = await CryptoService.hashPassword(password);

      // ACT
      final isValid = await CryptoService.verifyPassword(wrongPassword, hash);

      // ASSERT
      expect(isValid, isFalse);
    });

    test('相同密码应该生成不同哈希（加盐）', () async {
      // ARRANGE
      const password = 'TestP@ss123';

      // ACT
      final hash1 = await CryptoService.hashPassword(password);
      final hash2 = await CryptoService.hashPassword(password);

      // ASSERT
      expect(hash1, isNot(equals(hash2)));
    });
  });

  group('CryptoService - AES 加密', () {
    test('encryptAes 应该返回加密字符串', () async {
      // ARRANGE
      const plaintext = 'MySecretPassword123!';
      final key = Uint8List.fromList(List.generate(32, (i) => i));

      // ACT
      final encrypted = await CryptoService.encryptAes(plaintext, key);

      // ASSERT
      expect(encrypted, isNotNull);
      expect(encrypted, isNotEmpty);
      expect(encrypted, isNot(equals(plaintext)));
    });

    test('decryptAes 应该正确解密加密文本', () async {
      // ARRANGE
      const plaintext = 'MySecretPassword123!';
      final key = Uint8List.fromList(List.generate(32, (i) => i));
      final encrypted = await CryptoService.encryptAes(plaintext, key);

      // ACT
      final decrypted = await CryptoService.decryptAes(encrypted, key);

      // ASSERT
      expect(decrypted, equals(plaintext));
    });

    test('不同密钥应该无法解密', () async {
      // ARRANGE
      const plaintext = 'MySecretPassword123!';
      final key1 = Uint8List.fromList(List.generate(32, (i) => i));
      final key2 = Uint8List.fromList(List.generate(32, (i) => i + 1));
      final encrypted = await CryptoService.encryptAes(plaintext, key1);

      // ACT & ASSERT
      expect(
        () async => await CryptoService.decryptAes(encrypted, key2),
        throwsException,
      );
    });

    test('相同明文应该生成不同密文（使用 IV）', () async {
      // ARRANGE
      const plaintext = 'MySecretPassword123!';
      final key = Uint8List.fromList(List.generate(32, (i) => i));

      // ACT
      final encrypted1 = await CryptoService.encryptAes(plaintext, key);
      final encrypted2 = await CryptoService.encryptAes(plaintext, key);

      // ASSERT
      expect(encrypted1, isNot(equals(encrypted2)));
    });
  });

  group('CryptoService - 密钥派生', () {
    test('deriveAesKey 应该返回32字节密钥', () async {
      // ARRANGE
      const masterKey = 'MyMasterKey123!';
      final salt = Uint8List.fromList(List.generate(16, (i) => i));

      // ACT
      final aesKey = await CryptoService.deriveAesKey(masterKey, salt);

      // ASSERT
      expect(aesKey, isNotNull);
      expect(aesKey.length, equals(32));
    });

    test('deriveHmacKey 应该返回16字节密钥', () async {
      // ARRANGE
      const masterKey = 'MyMasterKey123!';
      final salt = Uint8List.fromList(List.generate(32, (i) => i));

      // ACT
      final hmacKey = await CryptoService.deriveHmacKey(masterKey, salt);

      // ASSERT
      expect(hmacKey, isNotNull);
      expect(hmacKey.length, equals(16));
    });

    test('相同主密码和盐应该生成相同密钥', () async {
      // ARRANGE
      const masterKey = 'MyMasterKey123!';
      final salt = Uint8List.fromList(List.generate(16, (i) => i));

      // ACT
      final key1 = await CryptoService.deriveAesKey(masterKey, salt);
      final key2 = await CryptoService.deriveAesKey(masterKey, salt);

      // ASSERT
      expect(key1, equals(key2));
    });

    test('不同盐应该生成不同密钥', () async {
      // ARRANGE
      const masterKey = 'MyMasterKey123!';
      final salt1 = Uint8List.fromList(List.generate(16, (i) => i));
      final salt2 = Uint8List.fromList(List.generate(16, (i) => i + 1));

      // ACT
      final key1 = await CryptoService.deriveAesKey(masterKey, salt1);
      final key2 = await CryptoService.deriveAesKey(masterKey, salt2);

      // ASSERT
      expect(key1, isNot(equals(key2)));
    });
  });

  group('CryptoService - HMAC', () {
    test('computeHmac 应该返回64字符十六进制字符串', () async {
      // ARRANGE
      final data = {'url': 'https://example.com', 'username': 'test'};
      final key = Uint8List.fromList(List.generate(16, (i) => i));

      // ACT
      final hmac = await CryptoService.computeHmac(data, key);

      // ASSERT
      expect(hmac, isNotNull);
      expect(hmac.length, equals(64));
      expect(RegExp(r'^[a-f0-9]{64}\$').hasMatch(hmac), isTrue);
    });

    test('相同数据和密钥应该生成相同 HMAC', () async {
      // ARRANGE
      final data = {'url': 'https://example.com', 'username': 'test'};
      final key = Uint8List.fromList(List.generate(16, (i) => i));

      // ACT
      final hmac1 = await CryptoService.computeHmac(data, key);
      final hmac2 = await CryptoService.computeHmac(data, key);

      // ASSERT
      expect(hmac1, equals(hmac2));
    });

    test('不同数据应该生成不同 HMAC', () async {
      // ARRANGE
      final data1 = {'url': 'https://example.com', 'username': 'test1'};
      final data2 = {'url': 'https://example.com', 'username': 'test2'};
      final key = Uint8List.fromList(List.generate(16, (i) => i));

      // ACT
      final hmac1 = await CryptoService.computeHmac(data1, key);
      final hmac2 = await CryptoService.computeHmac(data2, key);

      // ASSERT
      expect(hmac1, isNot(equals(hmac2)));
    });

    test('verifyHmac 应该正确验证 HMAC', () async {
      // ARRANGE
      final data = {'url': 'https://example.com', 'username': 'test'};
      final key = Uint8List.fromList(List.generate(16, (i) => i));
      final hmac = await CryptoService.computeHmac(data, key);

      // ACT
      final isValid = await CryptoService.verifyHmac(data, key, hmac);

      // ASSERT
      expect(isValid, isTrue);
    });

    test('verifyHmac 应该拒绝错误的 HMAC', () async {
      // ARRANGE
      final data = {'url': 'https://example.com', 'username': 'test'};
      final key = Uint8List.fromList(List.generate(16, (i) => i));

      // ACT
      final isValid = await CryptoService.verifyHmac(data, key, 'wrong_hmac');

      // ASSERT
      expect(isValid, isFalse);
    });
  });

  group('CryptoService - 密码强度评估', () {
    test('空密码应该返回0级', () {
      expect(CryptoService.getPasswordLevel(''), equals(0));
    });

    test('弱密码应该返回低级别', () {
      expect(CryptoService.getPasswordLevel('123'), equals(0));
      expect(CryptoService.getPasswordLevel('password'), equals(0));
      expect(CryptoService.getPasswordLevel('123456'), equals(0));
    });

    test('中等强度密码应该返回中等级别', () {
      expect(CryptoService.getPasswordLevel('Password1'), greaterThanOrEqualTo(1));
      expect(CryptoService.getPasswordLevel('Password1'), lessThanOrEqualTo(3));
    });

    test('强密码应该返回高级别', () {
      expect(CryptoService.getPasswordLevel('MyStr0ng!P@ss'), greaterThanOrEqualTo(3));
    });

    test('超强密码应该返回5级', () {
      expect(CryptoService.getPasswordLevel('MyV3ryStr0ng!P@ssw0rd2024'), equals(5));
    });
  });

  group('CryptoService - 盐值生成', () {
    test('generateEncryptionSalt 应该返回16字节', () async {
      final salt = await CryptoService.generateEncryptionSalt();
      expect(salt.length, equals(16));
    });

    test('generateHmacSalt 应该返回32字节', () async {
      final salt = await CryptoService.generateHmacSalt();
      expect(salt.length, equals(32));
    });

    test('每次生成应该不同', () async {
      final salt1 = await CryptoService.generateEncryptionSalt();
      final salt2 = await CryptoService.generateEncryptionSalt();
      expect(salt1, isNot(equals(salt2)));
    });
  });

  group('CryptoService - 完整加密流程', () {
    test('应该能完整加密和解密密码条目', () async {
      // ARRANGE - 模拟完整流程
      const masterPassword = 'MyMasterKey123!';
      const plaintextPassword = 'MySecretPassword123!';

      // 1. 生成盐值
      final encSalt = await CryptoService.generateEncryptionSalt();
      final hmacSalt = await CryptoService.generateHmacSalt();

      // 2. 派生密钥
      final aesKey = await CryptoService.deriveAesKey(masterPassword, encSalt);
      final hmacKey = await CryptoService.deriveHmacKey(masterPassword, hmacSalt);

      // 3. 加密密码
      final encrypted = await CryptoService.encryptAes(plaintextPassword, aesKey);

      // 4. 计算 HMAC
      final data = {'password': encrypted};
      final hmac = await CryptoService.computeHmac(data, hmacKey);

      // 5. 解密验证
      final decrypted = await CryptoService.decryptAes(encrypted, aesKey);

      // 6. HMAC 验证
      final isValid = await CryptoService.verifyHmac(data, hmacKey, hmac);

      // ASSERT
      expect(decrypted, equals(plaintextPassword));
      expect(isValid, isTrue);
    });
  });
}
