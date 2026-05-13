import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/app.dart';
import 'package:keybook/core/network/api_response.dart';
import 'package:keybook/core/network/token_manager.dart';
import 'package:keybook/data/models/key_item_model.dart';
import 'package:keybook/data/providers/providers.dart';
import 'package:keybook/data/repositories/auth_repository.dart';
import 'package:keybook/data/repositories/keybook_repository.dart';
import 'package:keybook/features/auth/lock_screen.dart';

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

class _FakeKeyBookRepository extends KeyBookRepository {
  @override
  Future<PaginatedResponse<KeyItemModel>> getItems({
    int page = 1,
    int pageSize = 20,
  }) async {
    return PaginatedResponse<KeyItemModel>(
      items: const [],
      total: 0,
      page: page,
      pageSize: pageSize,
    );
  }
}

void main() {
  setupTestEnvironment();

  setUp(() {
    final secureStorage = <String, String>{
      TokenKeys.masterPassword: 'Zxcm1234AB',
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

  testWidgets('锁定后手动解锁输入区会直接显示在锁屏页上层', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(_FakeSessionAuthRepository()),
          keyBookRepositoryProvider.overrideWithValue(_FakeKeyBookRepository()),
        ],
        child: const KeyBookApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    expect(find.text('暂无密码条目'), findsOneWidget);

    final appState = tester.state(find.byType(KeyBookApp));
    (appState as dynamic).didChangeAppLifecycleState(AppLifecycleState.paused);
    await tester.pumpAndSettle();

    expect(find.text('密码本已锁定'), findsOneWidget);

    await tester.tap(find.text('输入密码解锁'));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(LockScreen),
        matching: find.text('输入主密码解锁'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(LockScreen),
        matching: find.byType(TextFormField),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(LockScreen),
        matching: find.text('请输入当前主密码'),
      ),
      findsOneWidget,
    );
  });
}