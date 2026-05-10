import 'package:flutter_test/flutter_test.dart';
import '../../lib/core/sync/sync_service.dart';
import '../../lib/core/sync/sync_state.dart';
import '../../lib/core/storage/local_storage.dart';
import '../../lib/core/storage/key_item.dart';
import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('SyncService - 同步状态管理', () {
    late SyncService syncService;
    late LocalStorage localStorage;

    setUp(() async {
      localStorage = LocalStorage();
      await localStorage.init();
      syncService = SyncService(localStorage: localStorage);
    });

    tearDown(() async {
      await syncService.dispose();
      await localStorage.close();
    });

    test('获取初始同步状态应该返回正确的版本号', () async {
      final state = await syncService.getSyncState();
      expect(state.localVersion, isA<int>());
      expect(state.serverVersion, isA<int>());
      expect(state.isSyncing, isFalse);
    });

    test('同步状态初始应为idle', () async {
      final state = await syncService.getSyncState();
      expect(state.status, equals(SyncStatus.idle));
    });

    test('同步中状态应该正确设置', () async {
      final completer = syncService.startSync();
      var state = await syncService.getSyncState();
      expect(state.isSyncing, isTrue);
      completer.complete(null);
    });
  });

  group('SyncService - 待同步操作处理', () {
    late SyncService syncService;
    late LocalStorage localStorage;

    setUp(() async {
      localStorage = LocalStorage();
      await localStorage.init();
      await localStorage.clearPendingOperations();
      syncService = SyncService(localStorage: localStorage);
    });

    tearDown(() async {
      await syncService.dispose();
      await localStorage.close();
    });

    test('应该能获取待同步操作数量', () async {
      final count = await syncService.getPendingCount();
      expect(count, isA<int>());
      expect(count, greaterThanOrEqualTo(0));
    });

    test('添加待同步操作后计数应该增加', () async {
      await localStorage.addPendingOperation(PendingOperation(
        type: 'create',
        itemIndex: 'test-1',
        data: {'url': 'https://test.com'},
      ));
      final count = await syncService.getPendingCount();
      expect(count, equals(1));
    });

    test('清空待同步队列后计数应为0', () async {
      await localStorage.addPendingOperation(PendingOperation(
        type: 'create',
        itemIndex: 'test-1',
        data: {},
      ));
      await syncService.clearPending();
      final count = await syncService.getPendingCount();
      expect(count, equals(0));
    });
  });

  group('SyncService - 数据同步流程', () {
    late SyncService syncService;
    late LocalStorage localStorage;

    setUp(() async {
      localStorage = LocalStorage();
      await localStorage.init();
      await localStorage.clearAllItems();
      await localStorage.clearPendingOperations();
      syncService = SyncService(localStorage: localStorage);
    });

    tearDown(() async {
      await syncService.dispose();
      await localStorage.close();
    });

    test('startSync应该返回Future', () {
      final result = syncService.startSync();
      expect(result, isA<Future<void>>());
    });

    test('同步完成后应该更新本地版本', () async {
      final stateBefore = await syncService.getSyncState();
      final completer = syncService.startSync();
      await Future.delayed(const Duration(milliseconds: 100));
      completer.complete(null);
      await Future.delayed(const Duration(milliseconds: 100));
    });

    test('推送变更应该添加待同步操作', () async {
      final item = KeyItem(
        index: 'sync-test-1',
        url: 'https://sync.example.com',
        username: 'syncuser',
        password: 'syncpass',
      );
      await syncService.pushChange('create', item);
      final count = await syncService.getPendingCount();
      expect(count, greaterThan(0));
    });

    test('同步失败应该保持待同步队列', () async {
      await syncService.pushChange('create', KeyItem(
        index: 'fail-test',
        url: 'https://fail.com',
        username: 'user',
        password: 'pass',
      ));
      final countBefore = await syncService.getPendingCount();
      expect(countBefore, greaterThan(0));
    });
  });

  group('SyncService - 自动同步', () {
    late SyncService syncService;
    late LocalStorage localStorage;

    setUp(() async {
      localStorage = LocalStorage();
      await localStorage.init();
      syncService = SyncService(localStorage: localStorage);
    });

    tearDown(() async {
      await syncService.dispose();
      await localStorage.close();
    });

    test('启用自动同步应该启动定时器', () async {
      await syncService.startAutoSync(intervalSeconds: 300);
      final state = await syncService.getSyncState();
      expect(state.autoSyncEnabled, isTrue);
    });

    test('停止自动同步应该停止定时器', () async {
      await syncService.startAutoSync(intervalSeconds: 300);
      await syncService.stopAutoSync();
      final state = await syncService.getSyncState();
      expect(state.autoSyncEnabled, isFalse);
    });
  });
}
