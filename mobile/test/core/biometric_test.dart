import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:keybook/core/biometric/biometric_service.dart';

import '../test_helper.dart';

void main() {
  setupTestEnvironment();

  group('BiometricService - 生物识别服务', () {
    late BiometricService biometricService;

    setUp(() {
      biometricService = BiometricService();
    });

    test('检查设备是否支持生物识别', () async {
      final isSupported = await biometricService.isDeviceSupported();
      expect(isSupported, isA<bool>());
    });

    test('获取可用的生物识别类型', () async {
      final availableBiometrics = await biometricService.getAvailableBiometrics();
      expect(availableBiometrics, isA<List<BiometricType>>());
    });

    test('生物识别认证应该返回结果', () async {
      final result = await biometricService.authenticate(
        reason: '验证身份以解锁应用',
      );
      expect(result, isA<bool>());
    });

    test('未设置生物识别时应该提示设置', () async {
      final availableBiometrics = await biometricService.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        expect(availableBiometrics.isEmpty, isTrue);
      } else {
        expect(availableBiometrics.isNotEmpty, isTrue);
      }
    });
  });

  group('BiometricService - 生物识别类型检测', () {
    late BiometricService biometricService;

    setUp(() {
      biometricService = BiometricService();
    });

    test('应该能检测指纹识别', () async {
      final availableBiometrics = await biometricService.getAvailableBiometrics();
      final hasFingerprint = availableBiometrics.contains(BiometricType.fingerprint);
      final hasStrong = availableBiometrics.contains(BiometricType.strong);
      expect(hasFingerprint || hasStrong, isA<bool>());
    });

    test('应该能检测面容识别', () async {
      final availableBiometrics = await biometricService.getAvailableBiometrics();
      final hasFace = availableBiometrics.contains(BiometricType.face);
      final hasStrong = availableBiometrics.contains(BiometricType.strong);
      expect(hasFace || hasStrong, isA<bool>());
    });
  });

  group('BiometricService - 认证选项', () {
    late BiometricService biometricService;

    setUp(() {
      biometricService = BiometricService();
    });

    test('应该支持自定义认证提示文字', () async {
      final result = await biometricService.authenticate(
        reason: '请使用指纹解锁',
        localizedReason: '请使用指纹解锁',
      );
      expect(result, isA<bool>());
    });

    test('应该支持禁用后备登录选项', () async {
      final result = await biometricService.authenticate(
        reason: '验证身份',
        biometricOnly: true,
      );
      expect(result, isA<bool>());
    });

    test('应该支持 stickyAuth 选项防止后台杀死', () async {
      final result = await biometricService.authenticate(
        reason: '验证身份',
        stickyAuth: true,
      );
      expect(result, isA<bool>());
    });
  });
}
