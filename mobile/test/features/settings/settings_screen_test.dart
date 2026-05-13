import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/core/biometric/biometric_service.dart';
import 'package:keybook/core/network/token_manager.dart';
import 'package:keybook/data/providers/providers.dart';
import 'package:keybook/data/repositories/auth_repository.dart';
import 'package:keybook/features/settings/settings_screen.dart';
import 'package:local_auth/local_auth.dart';

import '../../test_helper.dart';

const MethodChannel _secureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

class _FakeSessionAuthRepository extends AuthRepository {
  @override
  Future<bool> hasValidSession() async => true;

  @override
  Future<void> logout() async {}
}

class _FakeBiometricService extends BiometricService {
  _FakeBiometricService({
    required this.isSupported,
    required this.availableBiometrics,
    required this.authenticateResult,
  });

  final bool isSupported;
  final List<BiometricType> availableBiometrics;
  final bool authenticateResult;

  @override
  Future<bool> isDeviceSupported() async => isSupported;

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async => availableBiometrics;

  @override
  Future<bool> authenticate({
    required String reason,
    String? localizedReason,
    bool biometricOnly = false,
    bool stickyAuth = true,
    bool sensitiveTransaction = true,
  }) async {
    return authenticateResult;
  }
}

void main() {
  setupTestEnvironment();

  setUp(() {
    final secureStorage = <String, String>{
      TokenKeys.masterPassword: 'Kwnb0513Aa',
    };

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, (call) async {
          final arguments = Map<String, dynamic>.from(
            call.arguments as Map? ?? const <String, dynamic>{},
          );
          final key = arguments['key'] as String?;

          switch (call.method) {
            case 'read':
              if (key == null) {
                return null;
              }
              return secureStorage[key];
            case 'write':
              if (key != null) {
                secureStorage[key] = arguments['value'] as String;
              }
              return null;
            case 'delete':
              if (key != null) {
                secureStorage.remove(key);
              }
              return null;
            case 'deleteAll':
              secureStorage.clear();
              return null;
            case 'containsKey':
              if (key == null) {
                return false;
              }
              return secureStorage.containsKey(key);
            case 'readAll':
              return Map<String, String>.from(secureStorage);
            default:
              return null;
          }
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, null);
  });

  testWidgets('设置页可以打开主要子页面入口', (tester) async {
    await _pumpSettingsScreen(tester);

    final cases = <({String entry, String title})>[
      (entry: '个人信息', title: '个人信息'),
      (entry: '修改密码', title: '修改密码'),
      (entry: '导出数据', title: '导出数据'),
      (entry: '导入数据', title: '导入数据'),
      (entry: '用户协议', title: '用户协议'),
      (entry: '隐私政策', title: '隐私政策'),
    ];

    for (final item in cases) {
      await _tapSettingsEntry(tester, item.entry);
      await tester.pumpAndSettle();

      expect(find.text(item.title), findsWidgets);

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('设置'), findsOneWidget);
    }
  });

  testWidgets('设置页切换同步与隐藏密码开关会更新界面状态', (tester) async {
    await _pumpSettingsScreen(tester);

    Finder autoSyncSwitch() => _settingsSwitch('自动同步');
    Finder wifiOnlySwitch() => _settingsSwitch('仅在 Wi-Fi 下同步');
    Finder hidePasswordsSwitch() => _settingsSwitch('隐藏密码');

    expect(tester.widget<Switch>(autoSyncSwitch()).value, isTrue);
    expect(tester.widget<Switch>(wifiOnlySwitch()).value, isFalse);
    expect(tester.widget<Switch>(hidePasswordsSwitch()).value, isTrue);

    await tester.tap(autoSyncSwitch());
    await tester.pumpAndSettle();
    await tester.tap(wifiOnlySwitch());
    await tester.pumpAndSettle();
    await _scrollSettingsTextIntoView(tester, '隐藏密码');
    await tester.tap(hidePasswordsSwitch());
    await tester.pumpAndSettle();

    await _scrollSettingsTextIntoView(tester, '自动同步', delta: -300);
    expect(tester.widget<Switch>(autoSyncSwitch()).value, isFalse);
    expect(tester.widget<Switch>(wifiOnlySwitch()).value, isTrue);

    await _scrollSettingsTextIntoView(tester, '隐藏密码');
    expect(tester.widget<Switch>(hidePasswordsSwitch()).value, isFalse);
  });

  testWidgets('设置页选择自动锁定时间后会更新副标题', (tester) async {
    await _pumpSettingsScreen(tester);

    expect(find.text('1 分钟无操作后'), findsOneWidget);

    await tester.tap(find.text('自动锁定'));
    await tester.pumpAndSettle();

    expect(find.text('自动锁定时间'), findsOneWidget);

    await tester.tap(find.text('15 分钟'));
    await tester.pumpAndSettle();

    expect(find.text('15 分钟无操作后'), findsOneWidget);
  });

  testWidgets('设备不支持生物识别时会提示且保持关闭', (tester) async {
    await _pumpSettingsScreen(
      tester,
      biometricService: _FakeBiometricService(
        isSupported: false,
        availableBiometrics: const <BiometricType>[],
        authenticateResult: false,
      ),
    );

    final biometricSwitch = _settingsSwitch('生物识别');
    expect(tester.widget<Switch>(biometricSwitch).value, isFalse);

    await tester.tap(biometricSwitch);
    await tester.pumpAndSettle();

    expect(find.text('当前设备未配置可用的生物识别能力'), findsOneWidget);
    expect(tester.widget<Switch>(biometricSwitch).value, isFalse);
  });

  testWidgets('生物识别验证失败时会提示且保持关闭', (tester) async {
    await _pumpSettingsScreen(
      tester,
      biometricService: _FakeBiometricService(
        isSupported: true,
        availableBiometrics: const <BiometricType>[BiometricType.fingerprint],
        authenticateResult: false,
      ),
    );

    final biometricSwitch = _settingsSwitch('生物识别');

    await tester.tap(biometricSwitch);
    await tester.pumpAndSettle();

    expect(find.text('生物识别验证未通过，未启用该功能'), findsOneWidget);
    expect(tester.widget<Switch>(biometricSwitch).value, isFalse);
  });

  testWidgets('生物识别验证成功时会启用开关并提示成功', (tester) async {
    await _pumpSettingsScreen(
      tester,
      biometricService: _FakeBiometricService(
        isSupported: true,
        availableBiometrics: const <BiometricType>[BiometricType.fingerprint],
        authenticateResult: true,
      ),
    );

    final biometricSwitch = _settingsSwitch('生物识别');

    await tester.tap(biometricSwitch);
    await tester.pumpAndSettle();

    expect(find.text('已启用生物识别解锁'), findsOneWidget);
    expect(tester.widget<Switch>(biometricSwitch).value, isTrue);
  });
}

Future<void> _pumpSettingsScreen(
  WidgetTester tester, {
  BiometricService? biometricService,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(_FakeSessionAuthRepository()),
        if (biometricService != null)
          biometricServiceProvider.overrideWithValue(biometricService),
      ],
      child: const MaterialApp(home: SettingsScreen()),
    ),
  );

  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pumpAndSettle();
}

Finder _settingsSwitch(String title) {
  final tile = find.ancestor(
    of: find.text(title),
    matching: find.byType(ListTile),
  );

  return find.descendant(of: tile, matching: find.byType(Switch));
}

Future<void> _tapSettingsEntry(WidgetTester tester, String title) async {
  final entry = find.text(title);
  await _scrollSettingsFinderIntoView(tester, entry);
  await tester.tap(entry.last);
}

Future<void> _scrollSettingsTextIntoView(
  WidgetTester tester,
  String title, {
  double delta = 300,
}) async {
  await _scrollSettingsFinderIntoView(tester, find.text(title), delta: delta);
}

Future<void> _scrollSettingsFinderIntoView(
  WidgetTester tester,
  Finder finder, {
  double delta = 300,
}) async {
  await tester.scrollUntilVisible(
    finder,
    delta,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}