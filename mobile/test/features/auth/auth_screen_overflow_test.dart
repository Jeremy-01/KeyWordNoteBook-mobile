import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/data/providers/providers.dart';
import 'package:keybook/data/repositories/auth_repository.dart';
import 'package:keybook/features/auth/login_screen.dart';
import 'package:keybook/features/auth/register_screen.dart';

import '../../test_helper.dart';

const MethodChannel _secureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

class _FakeUnauthenticatedAuthRepository extends AuthRepository {
  @override
  Future<bool> hasValidSession() async => false;
}

void main() {
  setupTestEnvironment();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, (call) async {
          switch (call.method) {
            case 'read':
              return null;
            case 'containsKey':
              return false;
            case 'readAll':
              return <String, String>{};
            default:
              return null;
          }
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, null);
  });

  testWidgets('登录页在键盘弹出后不会出现 overflow', (tester) async {
    tester.view.physicalSize = const Size(390, 780);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            _FakeUnauthenticatedAuthRepository(),
          ),
        ],
        child: const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(390, 780),
              viewInsets: EdgeInsets.only(bottom: 320),
            ),
            child: LoginScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('登录到你的保险库'), findsOneWidget);
  });

  testWidgets('注册页在键盘弹出后不会出现 overflow', (tester) async {
    tester.view.physicalSize = const Size(390, 780);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            _FakeUnauthenticatedAuthRepository(),
          ),
        ],
        child: const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(390, 780),
              viewInsets: EdgeInsets.only(bottom: 320),
            ),
            child: RegisterScreen(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('创建账户'), findsOneWidget);
  });
}