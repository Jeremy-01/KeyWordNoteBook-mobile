import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../lib/data/providers/providers.dart';
import '../../lib/data/providers/auth_provider.dart';
import '../../lib/data/providers/keybook_provider.dart';
import '../../lib/core/storage/local_storage.dart';
import '../../lib/core/biometric/biometric_service.dart';
import '../../lib/core/sync/sync_service.dart';
import '../../lib/core/sync/sync_state.dart';
import '../../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('SettingsProvider - 设置状态管理', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('生物识别开关状态初始应为false', () {
      final settings = container.read(settingsProvider);
      expect(settings.biometricEnabled, isFalse);
    });

    test('自动同步开关状态初始应为true', () {
      final settings = container.read(settingsProvider);
      expect(settings.autoSyncEnabled, isTrue);
    });

    test('Wi-Fi同步开关状态初始应为false', () {
      final settings = container.read(settingsProvider);
      expect(settings.wifiOnlySync, isFalse);
    });

    test('隐藏密码开关状态初始应为true', () {
      final settings = container.read(settingsProvider);
      expect(settings.hidePasswords, isTrue);
    });

    test('应该能切换生物识别开关', () async {
      await container.read(settingsProvider.notifier).toggleBiometric();
      final settings = container.read(settingsProvider);
      expect(settings.biometricEnabled, isTrue);
    });

    test('应该能切换自动同步开关', () async {
      await container.read(settingsProvider.notifier).toggleAutoSync();
      final settings = container.read(settingsProvider);
      expect(settings.autoSyncEnabled, isFalse);
    });

    test('应该能切换Wi-Fi同步开关', () async {
      await container.read(settingsProvider.notifier).toggleWifiOnlySync();
      final settings = container.read(settingsProvider);
      expect(settings.wifiOnlySync, isTrue);
    });

    test('应该能切换隐藏密码开关', () async {
      await container.read(settingsProvider.notifier).toggleHidePasswords();
      final settings = container.read(settingsProvider);
      expect(settings.hidePasswords, isFalse);
    });

    test('应该能设置自动锁定时间', () async {
      await container.read(settingsProvider.notifier).setAutoLockDuration(5);
      final settings = container.read(settingsProvider);
      expect(settings.autoLockMinutes, equals(5));
    });
  });

  group('BiometricService集成 - Provider层', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('生物识别服务应该可用', () async {
      final service = container.read(biometricServiceProvider);
      expect(service, isNotNull);
      final isSupported = await service.isDeviceSupported();
      expect(isSupported, isA<bool>());
    });

    test('设备应该能检测到生物识别类型', () async {
      final service = container.read(biometricServiceProvider);
      final types = await service.getAvailableBiometrics();
      expect(types, isA<List>());
    });
  });

  group('SyncService集成 - Provider层', () {
    late ProviderContainer container;
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      container = ProviderContainer(
        overrides: [
          localStorageProvider.overrideWithValue(storage),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await storage.close();
    });

    test('同步服务应该可用', () {
      final service = container.read(syncServiceProvider);
      expect(service, isNotNull);
    });

    test('同步状态初始应为idle', () async {
      final state = await container.read(syncServiceProvider).getSyncState();
      expect(state.status, equals(SyncStatus.idle));
    });

    test('自动同步开关应该控制服务', () async {
      await container.read(settingsProvider.notifier).toggleAutoSync();
      await container.read(syncServiceProvider).startAutoSync(intervalSeconds: 300);
      final state = await container.read(syncServiceProvider).getSyncState();
      expect(state.autoSyncEnabled, isTrue);
    });
  });

  group('KeyBookProvider与LocalStorage集成', () {
    late ProviderContainer container;
    late LocalStorage storage;

    setUp(() async {
      storage = LocalStorage();
      await storage.init();
      await storage.clearAllItems();
      await storage.clearPendingOperations();
      container = ProviderContainer(
        overrides: [
          localStorageProvider.overrideWithValue(storage),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await storage.close();
    });

    test('本地存储应该可用', () async {
      final localStorage = container.read(localStorageProvider);
      expect(localStorage.isInitialized, isTrue);
    });

    test('密码本状态应该能更新本地版本', () async {
      await storage.saveSyncVersion(5);
      final state = await container.read(syncServiceProvider).getSyncState();
      expect(state.localVersion, equals(5));
    });

    test('添加待同步操作应该增加计数', () async {
      await container.read(syncServiceProvider).pushChange('create', null);
      final count = await container.read(syncServiceProvider).getPendingCount();
      expect(count, greaterThan(0));
    });
  });
}
