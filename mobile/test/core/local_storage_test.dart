import 'package:flutter_test/flutter_test.dart';

import '../../lib/core/storage/local_storage.dart';
import '../../lib/core/storage/key_item.dart';
import '../../lib/core/storage/pending_operation.dart';
import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('LocalStorage - 数据库初始化', () {
    test('数据库应该能正常初始化', () async {
      final storage = LocalStorage();
      await storage.init();
      expect(storage.isInitialized, isTrue);
    });

    test('重复初始化应该安全', () async {
      final storage = LocalStorage();
      await storage.init();
      expect(() async => await storage.init(), returnsNormally);
    });

    test('关闭数据库应该成功', () async {
      final storage = LocalStorage();
      await storage.init();
      await storage.close();
      expect(storage.isInitialized, isFalse);
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
      final item = KeyItem(
        index: '1',
        url: 'https://github.com',
        username: 'testuser',
        password: 'testpass123',
      );
      await storage.insertItem(item);
      final items = await storage.getAllItems();
      expect(items.length, equals(1));
      expect(items.first.url, equals('https://github.com'));
    });

    test('批量插入密码条目应该成功', () async {
      final items = [
        KeyItem(index: '1', url: 'https://github.com', username: 'user1', password: 'pass1'),
        KeyItem(index: '2', url: 'https://gitlab.com', username: 'user2', password: 'pass2'),
      ];
      await storage.insertItems(items);
      final results = await storage.getAllItems();
      expect(results.length, equals(2));
    });

    test('根据索引获取密码条目应该成功', () async {
      final item = KeyItem(index: '1', url: 'https://github.com', username: 'testuser', password: 'testpass');
      await storage.insertItem(item);
      final result = await storage.getItemByIndex('1');
      expect(result, isNotNull);
      expect(result!.url, equals('https://github.com'));
    });

    test('更新密码条目应该成功', () async {
      final item = KeyItem(index: '1', url: 'https://github.com', username: 'testuser', password: 'testpass');
      await storage.insertItem(item);
      final updated = KeyItem(index: '1', url: 'https://github.com', username: 'testuser', password: 'newpass');
      await storage.updateItem(updated);
      final result = await storage.getItemByIndex('1');
      expect(result!.password, equals('newpass'));
    });

    test('删除密码条目应该成功', () async {
      final item = KeyItem(index: '1', url: 'https://github.com', username: 'testuser', password: 'testpass');
      await storage.insertItem(item);
      await storage.deleteItem('1');
      final result = await storage.getItemByIndex('1');
      expect(result, isNull);
    });

    test('清空所有密码条目应该成功', () async {
      final items = [
        KeyItem(index: '1', url: 'https://github.com', username: 'user1', password: 'pass1'),
        KeyItem(index: '2', url: 'https://gitlab.com', username: 'user2', password: 'pass2'),
      ];
      await storage.insertItems(items);
      await storage.clearAllItems();
      final results = await storage.getAllItems();
      expect(results.isEmpty, isTrue);
    });

    test('搜索密码条目应该成功', () async {
      final items = [
        KeyItem(index: '1', url: 'https://github.com', username: 'user1', password: 'pass1'),
        KeyItem(index: '2', url: 'https://gitlab.com', username: 'user2', password: 'pass2'),
      ];
      await storage.insertItems(items);
      final results = await storage.searchItems('github');
      expect(results.length, equals(1));
      expect(results.first.url, contains('github'));
    });
  });

  group('LocalStorage - 同步状态', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
    });

    tearDown(() async {
      await storage.close();
    });

    test('默认同步版本为 0', () async {
      final version = await storage.getSyncVersion();
      expect(version, equals(0));
    });

    test('保存和获取同步版本', () async {
      await storage.saveSyncVersion(5);
      final version = await storage.getSyncVersion();
      expect(version, equals(5));
    });

    test('保存和获取最后同步时间', () async {
      final now = DateTime.now();
      await storage.saveLastSyncTime(now);
      final lastSync = await storage.getLastSyncTime();
      expect(lastSync, isNotNull);
    });
  });

  group('LocalStorage - 待同步队列', () {
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
      await storage.clearPendingOperations();
    });

    tearDown(() async {
      await storage.close();
    });

    test('添加待同步操作', () async {
      final op = PendingOperation(
        type: 'create',
        itemIndex: '1',
        data: {'url': 'https://github.com'},
      );
      await storage.addPendingOperation(op);
      final ops = await storage.getPendingOperations();
      expect(ops.length, equals(1));
      expect(ops.first.type, equals('create'));
    });

    test('删除已完成的待同步操作', () async {
      final op = PendingOperation(
        type: 'update',
        itemIndex: '1',
        data: {'url': 'https://github.com'},
      );
      await storage.addPendingOperation(op);
      await storage.removePendingOperation('1', 'update');
      final ops = await storage.getPendingOperations();
      expect(ops.isEmpty, isTrue);
    });

    test('清空所有待同步操作', () async {
      final ops = [
        PendingOperation(type: 'create', itemIndex: '1', data: {}),
        PendingOperation(type: 'update', itemIndex: '2', data: {}),
      ];
      for (final op in ops) {
        await storage.addPendingOperation(op);
      }
      await storage.clearPendingOperations();
      final results = await storage.getPendingOperations();
      expect(results.isEmpty, isTrue);
    });
  });
}
