/// 本地/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import '/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.is/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', ()/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      ///// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功',/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted:/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2',/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2',/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel:/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        password/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      ///// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url:/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: '/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insert/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com',/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: '/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItem/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel:/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.search/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        Key/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel:/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(()/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSync/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    }/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // AR/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.get/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    }/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        item/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作',/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id:/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      ///// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(P/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime.now(),
      ));
      await storage.addPendingOperation(PendingOperation(
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime.now(),
      ));
      await storage.addPendingOperation(PendingOperation(
        id: 'op2', type: 'update', itemIndex: '2', data: {}, createdAt: DateTime.now(),
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime.now(),
      ));
      await storage.addPendingOperation(PendingOperation(
        id: 'op2', type: 'update', itemIndex: '2', data: {}, createdAt: DateTime.now(),
      ));

      // ACT
      await storage.clearPendingOperations();
      final ops = await storage.getPendingOperations();

      ///// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime.now(),
      ));
      await storage.addPendingOperation(PendingOperation(
        id: 'op2', type: 'update', itemIndex: '2', data: {}, createdAt: DateTime.now(),
      ));

      // ACT
      await storage.clearPendingOperations();
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });
  });
}
/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime.now(),
      ));
      await storage.addPendingOperation(PendingOperation(
        id: 'op2', type: 'update', itemIndex: '2', data: {}, createdAt: DateTime.now(),
      ));

      // ACT
      await storage.clearPendingOperations();
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });
  });
}

/// 本地存储接口定义（测试期望）
/// 实际实现将在 local_storage/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime.now(),
      ));
      await storage.addPendingOperation(PendingOperation(
        id: 'op2', type: 'update', itemIndex: '2', data: {}, createdAt: DateTime.now(),
      ));

      // ACT
      await storage.clearPendingOperations();
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });
  });
}

/// 本地存储接口定义（测试期望）
/// 实际实现将在 local_storage.dart 中
class LocalStorage {
  bool isInitialized = false;

  Future<void> init() async {
    throw Un/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime.now(),
      ));
      await storage.addPendingOperation(PendingOperation(
        id: 'op2', type: 'update', itemIndex: '2', data: {}, createdAt: DateTime.now(),
      ));

      // ACT
      await storage.clearPendingOperations();
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });
  });
}

/// 本地存储接口定义（测试期望）
/// 实际实现将在 local_storage.dart 中
class LocalStorage {
  bool isInitialized = false;

  Future<void> init() async {
    throw UnimplementedError('等待实现');
  }

  Future<void> close() async {
    throw UnimplementedError('等待实现');/// 本地存储测试 - TDD 方式
/// 先写测试，后实现代码
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      // ARRANGE
      final storage = LocalStorage();

      // ACT
      await storage.init();

      // ASSERT
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      // ARRANGE
      final storage = LocalStorage();
      await storage.init();

      // ACT & ASSERT
      expect(() async => await storage.init(), returnsNormally);
    });
  });

  group('LocalStorage - 密码条目 CRUD', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('插入密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
        note: 'GitHub 账号',
      );

      // ACT
      await storage.insertItem(item);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
      expect(items.first.username, equals('testuser'));
    });

    test('批量插入密码条目应该成功', () async {
      // ARRANGE
      final items = [
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://c.com', username: 'c', passwordEncrypted: 'p3', passwordLevel: 3),
      ];

      // ACT
      await storage.insertItems(items);
      final result = await storage.getAllItems();

      // ASSERT
      expect(result.length, equals(3));
    });

    test('更新密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final updated = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'newuser',
        passwordEncrypted: 'new_encrypted',
        passwordLevel: 5,
        note: 'Updated note',
      );
      await storage.updateItem(updated);
      final items = await storage.getAllItems();

      // ASSERT
      expect(items.first.username, equals('newuser'));
      expect(items.first.note, equals('Updated note'));
    });

    test('删除密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      await storage.deleteItem('1');
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });

    test('根据索引获取密码条目应该成功', () async {
      // ARRANGE
      final item = KeyItemLocal(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        passwordEncrypted: 'encrypted_password',
        passwordLevel: 4,
      );
      await storage.insertItem(item);

      // ACT
      final result = await storage.getItemByIndex('1');

      // ASSERT
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('搜索密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://github.com', username: 'user1', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://google.com', username: 'user2', passwordEncrypted: 'p2', passwordLevel: 2),
        KeyItemLocal(index: '3', url: 'https://gitlab.com', username: 'user3', passwordEncrypted: 'p3', passwordLevel: 3),
      ]);

      // ACT
      final results = await storage.searchItems('git');

      // ASSERT
      expect(results.length, equals(2));
      expect(results.any((i) => i.url.contains('github')), isTrue);
      expect(results.any((i) => i.url.contains('gitlab')), isTrue);
    });

    test('清空所有密码条目应该成功', () async {
      // ARRANGE
      await storage.insertItems([
        KeyItemLocal(index: '1', url: 'https://a.com', username: 'a', passwordEncrypted: 'p1', passwordLevel: 1),
        KeyItemLocal(index: '2', url: 'https://b.com', username: 'b', passwordEncrypted: 'p2', passwordLevel: 2),
      ]);

      // ACT
      await storage.clearAllItems();
      final items = await storage.getAllItems();

      // ASSERT
      expect(items, isEmpty);
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
    });

    tearDown(() async {
      await storage.close();
    });

    test('保存和获取同步版本', () async {
      // ARRANGE
      const version = 5;

      // ACT
      await storage.saveSyncVersion(version);
      final result = await storage.getSyncVersion();

      // ASSERT
      expect(result, equals(version));
    });

    test('保存和获取最后同步时间', () async {
      // ARRANGE
      final time = DateTime(2026, 5, 10, 12, 0, 0);

      // ACT
      await storage.saveLastSyncTime(time);
      final result = await storage.getLastSyncTime();

      // ASSERT
      expect(result, equals(time));
    });

    test('默认同步版本为 0', () async {
      // ACT
      final version = await storage.getSyncVersion();

      // ASSERT
      expect(version, equals(0));
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://example.com'},
        createdAt: DateTime.now(),
      );

      // ACT
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      // ARRANGE
      final op = PendingOperation(
        id: 'op1',
        type: 'create',
        itemIndex: '1',
        data: {},
        createdAt: DateTime.now(),
      );
      await storage.addPendingOperation(op);

      // ACT
      await storage.removePendingOperation('op1');
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });

    test('清空所有待同步操作', () async {
      // ARRANGE
      await storage.addPendingOperation(PendingOperation(
        id: 'op1', type: 'create', itemIndex: '1', data: {}, createdAt: DateTime.now(),
      ));
      await storage.addPendingOperation(PendingOperation(
        id: 'op2', type: 'update', itemIndex: '2', data: {}, createdAt: DateTime.now(),
      ));

      // ACT
      await storage.clearPendingOperations();
      final ops = await storage.getPendingOperations();

      // ASSERT
      expect(ops, isEmpty);
    });
  });
}

/// 本地存储接口定义（测试期望）
/// 实际实现将在 local_storage.dart 中
class LocalStorage {
  bool isInitialized = false;

  Future<void> init() async {
    throw UnimplementedError('等待实现');
  }

  Future<void> close() async {
    throw UnimplementedError('等待实现');
  }

  Future<void> insertItem(KeyItemLocal item) async {
    throw UnimplementedError('等待实现');
  }

  Future<void> insert