import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/app.dart';
import 'package:keybook/core/network/api_response.dart';
import 'package:keybook/core/network/token_manager.dart';
import 'package:keybook/data/models/auth_models.dart';
import 'package:keybook/data/models/key_item_model.dart';
import 'package:keybook/data/providers/auth_provider.dart';
import 'package:keybook/data/providers/providers.dart';
import 'package:keybook/data/repositories/auth_repository.dart';
import 'package:keybook/data/repositories/keybook_repository.dart';
import 'package:keybook/features/auth/login_screen.dart';
import 'package:keybook/features/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../test_helper.dart';

const MethodChannel _secureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

class _FakeAuthenticatedAuthRepository extends AuthRepository {
  bool logoutCalled = false;

  @override
  Future<bool> hasValidSession() async => true;

  @override
  Future<UserInfo> getCurrentUser() async {
    return UserInfo(
      userId: 'user-1',
      email: 'qa@example.com',
      createdAt: DateTime(2026, 5, 13),
    );
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }
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

class _AuthGateApp extends ConsumerWidget {
  const _AuthGateApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.isCheckingSession || authState.status == AuthStatus.initial) {
      return const MaterialApp(home: Scaffold(body: SizedBox.shrink()));
    }

    return MaterialApp(
      home: authState.isAuthenticated
          ? const SettingsScreen()
          : const LoginScreen(),
    );
  }
}

void main() {
  setupTestEnvironment();

  setUp(() {
    SharedPreferences.setMockInitialValues({});

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

  testWidgets('设置页确认退出后会回到登录页', (tester) async {
    final repository = _FakeAuthenticatedAuthRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
        ],
        child: const _AuthGateApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    expect(find.text('设置'), findsOneWidget);

    final settingsList = find.byType(ListView);
    expect(settingsList, findsOneWidget);

    await tester.drag(settingsList, const Offset(0, -1800));
    await tester.pumpAndSettle();

    final logoutButton = find.text('退出登录');
    expect(logoutButton, findsOneWidget);

    await tester.tap(logoutButton);
    await tester.pumpAndSettle();

    expect(find.text('确定要退出登录吗？'), findsOneWidget);

    final confirmLogoutButton = find.widgetWithText(TextButton, '退出');
    await tester.drag(settingsList, const Offset(0, -240));
    await tester.pumpAndSettle();
    await tester.tap(confirmLogoutButton);
    await tester.pumpAndSettle();

    expect(repository.logoutCalled, isTrue);
    expect(find.text('登录到你的保险库'), findsOneWidget);
    expect(find.text('设置'), findsNothing);
  });

  testWidgets('从首页进入设置后退出登录会回到登录页', (tester) async {
    final repository = _FakeAuthenticatedAuthRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          keyBookRepositoryProvider.overrideWithValue(_FakeKeyBookRepository()),
        ],
        child: const KeyBookApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    final settingsButton = find.byIcon(Icons.settings);
    expect(settingsButton, findsOneWidget);

    await tester.tap(settingsButton);
    await tester.pumpAndSettle();

    expect(find.text('设置'), findsOneWidget);

    final settingsList = find.byType(ListView);
    expect(settingsList, findsOneWidget);

    await tester.drag(settingsList, const Offset(0, -1800));
    await tester.pumpAndSettle();

    await tester.tap(find.text('退出登录'));
    await tester.pumpAndSettle();

    expect(find.text('确定要退出登录吗？'), findsOneWidget);

    final confirmLogoutButton = find.widgetWithText(TextButton, '退出');
    await tester.drag(settingsList, const Offset(0, -240));
    await tester.pumpAndSettle();
    await tester.tap(confirmLogoutButton);
    await tester.pumpAndSettle();

    expect(repository.logoutCalled, isTrue);
    expect(find.text('登录到你的保险库'), findsOneWidget);
    expect(find.text('设置'), findsNothing);
  });
}