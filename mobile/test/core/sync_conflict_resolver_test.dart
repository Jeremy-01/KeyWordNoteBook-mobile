import 'package:flutter_test/flutter_test.dart';
import '../../lib/core/sync/sync_conflict_resolver.dart';
import '../../lib/core/storage/key_item.dart';
import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('SyncConflictResolver - 冲突解决策略', () {
    late SyncConflictResolver resolver;

    setUp(() {
      resolver = SyncConflictResolver();
    });

    test('默认策略应为server_wins', () {
      expect(resolver.defaultStrategy, equals(ConflictStrategy.serverWins));
    });

    test('应该能设置冲突解决策略', () {
      resolver.setStrategy(ConflictStrategy.clientWins);
      expect(resolver.defaultStrategy, equals(ConflictStrategy.clientWins));
    });

    test('应该支持三种冲突策略', () {
      resolver.setStrategy(ConflictStrategy.serverWins);
      expect(resolver.supportedStrategies.length, equals(3));
    });
  });

  group('SyncConflictResolver - 冲突检测', () {
    late SyncConflictResolver resolver;

    setUp(() {
      resolver = SyncConflictResolver();
    });

    test('相同数据应该无冲突', () {
      final local = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'user',
        password: 'pass',
      );
      final server = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'user',
        password: 'pass',
      );
      expect(resolver.hasConflict(local, server), isFalse);
    });

    test('不同密码应该检测到冲突', () {
      final local = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'user',
        password: 'local_pass',
      );
      final server = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'user',
        password: 'server_pass',
      );
      expect(resolver.hasConflict(local, server), isTrue);
    });

    test('不同用户名应该检测到冲突', () {
      final local = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'local_user',
        password: 'pass',
      );
      final server = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'server_user',
        password: 'pass',
      );
      expect(resolver.hasConflict(local, server), isTrue);
    });
  });

  group('SyncConflictResolver - 冲突解决', () {
    late SyncConflictResolver resolver;

    setUp(() {
      resolver = SyncConflictResolver();
    });

    test('server_wins策略应返回服务端数据', () {
      resolver.setStrategy(ConflictStrategy.serverWins);
      final local = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'local_user',
        password: 'local_pass',
      );
      final server = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'server_user',
        password: 'server_pass',
      );
      final resolved = resolver.resolve(local, server);
      expect(resolved.username, equals('server_user'));
      expect(resolved.password, equals('server_pass'));
    });

    test('client_wins策略应返回本地数据', () {
      resolver.setStrategy(ConflictStrategy.clientWins);
      final local = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'local_user',
        password: 'local_pass',
      );
      final server = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'server_user',
        password: 'server_pass',
      );
      final resolved = resolver.resolve(local, server);
      expect(resolved.username, equals('local_user'));
      expect(resolved.password, equals('local_pass'));
    });

    test('last_write_wins策略应比较更新时间', () {
      resolver.setStrategy(ConflictStrategy.lastWriteWins);
      final local = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'local_user',
        password: 'local_pass',
      );
      final server = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'server_user',
        password: 'server_pass',
      );
      final resolved = resolver.resolve(local, server);
      expect(resolved.index, equals('1'));
    });

    test('解决冲突应该合并note字段', () {
      resolver.setStrategy(ConflictStrategy.serverWins);
      final local = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'user',
        password: 'pass',
        note: 'local note',
      );
      final server = KeyItem(
        index: '1',
        url: 'https://test.com',
        username: 'user',
        password: 'pass',
        note: 'server note',
      );
      final resolved = resolver.resolve(local, server);
      expect(resolved.note, isNotNull);
    });
  });

  group('SyncConflictResolver - 批量冲突解决', () {
    late SyncConflictResolver resolver;

    setUp(() {
      resolver = SyncConflictResolver();
    });

    test('应该能批量解决冲突', () {
      resolver.setStrategy(ConflictStrategy.serverWins);
      final conflicts = [
        ConflictPair(
          itemIndex: '1',
          local: KeyItem(index: '1', url: 'a', username: 'u1', password: 'p1'),
          server: KeyItem(index: '1', url: 'a', username: 'u2', password: 'p2'),
        ),
        ConflictPair(
          itemIndex: '2',
          local: KeyItem(index: '2', url: 'b', username: 'u3', password: 'p3'),
          server: KeyItem(index: '2', url: 'b', username: 'u4', password: 'p4'),
        ),
      ];
      final resolved = resolver.resolveAll(conflicts);
      expect(resolved.length, equals(2));
      expect(resolved[0].username, equals('u2'));
      expect(resolved[1].username, equals('u4'));
    });

    test('空冲突列表应该返回空结果', () {
      final resolved = resolver.resolveAll([]);
      expect(resolved.isEmpty, isTrue);
    });
  });
}
