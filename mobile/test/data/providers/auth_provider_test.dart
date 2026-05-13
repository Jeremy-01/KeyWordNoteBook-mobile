import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/data/models/auth_models.dart';
import 'package:keybook/data/providers/auth_provider.dart';
import 'package:keybook/data/repositories/auth_repository.dart';

import '../../test_helper.dart';

const MethodChannel _secureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

class _FakeAuthRepository extends AuthRepository {
  bool registerCalled = false;
  bool loginCalled = false;
  LoginRequest? lastLoginRequest;

  @override
  Future<bool> hasValidSession() async => false;

  @override
  Future<UserInfo> register(RegisterRequest request) async {
    registerCalled = true;
    return UserInfo(
      userId: 'user-1',
      email: request.email,
      createdAt: DateTime(2026, 5, 13),
    );
  }

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    loginCalled = true;
    lastLoginRequest = request;
    return AuthResponse(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
      expiresIn: 3600,
    );
  }

  @override
  Future<void> logout() async {}
}

void main() {
  setupTestEnvironment();

  setUp(() {
    final secureStorage = <String, String>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, (call) async {
          final arguments = Map<String, dynamic>.from(
            call.arguments as Map? ?? const <String, dynamic>{},
          );
          final key = arguments['key'] as String?;

          switch (call.method) {
            case 'write':
              if (key != null) {
                secureStorage[key] = arguments['value'] as String;
              }
              return null;
            case 'read':
              if (key == null) {
                return null;
              }
              return secureStorage[key];
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

  test('register also logs in to establish session', () async {
    final repository = _FakeAuthRepository();
    final notifier = AuthNotifier(repository);
    addTearDown(notifier.dispose);

    await wait();

    final success = await notifier.register(
      email: 'qa@example.com',
      password: 'Zxcm1234AB',
    );

    expect(success, isTrue);
    expect(repository.registerCalled, isTrue);
    expect(repository.loginCalled, isTrue);
    expect(repository.lastLoginRequest?.email, 'qa@example.com');
    expect(repository.lastLoginRequest?.password, 'Zxcm1234AB');
  });
}