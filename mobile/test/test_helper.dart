// 测试辅助工具
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keybook/core/storage/local_storage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const MethodChannel _localAuthChannel = MethodChannel(
  'plugins.flutter.io/local_auth',
);

bool _didSetupTestEnvironment = false;
int _testDatabaseCounter = 0;

// 设置测试环境
void setupTestEnvironment() {
  TestWidgetsFlutterBinding.ensureInitialized();

  if (_didSetupTestEnvironment) {
    return;
  }

  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(_localAuthChannel, (call) async {
    switch (call.method) {
      case 'isDeviceSupported':
        return true;
      case 'getAvailableBiometrics':
        return <String>['fingerprint', 'strong'];
      case 'authenticate':
      case 'stopAuthentication':
        return true;
      default:
        return null;
    }
  });

  _didSetupTestEnvironment = true;
}

LocalStorage createTestLocalStorage([String prefix = 'keybook_test']) {
  _testDatabaseCounter += 1;
  return LocalStorage(databaseName: '${prefix}_$_testDatabaseCounter.db');
}

// 异步等待
Future<void> wait({int milliseconds = 100}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}
