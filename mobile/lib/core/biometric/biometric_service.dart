import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> isDeviceSupported() async {
    return await _localAuth.isDeviceSupported();
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _localAuth.getAvailableBiometrics();
  }

  Future<bool> authenticate({
    required String reason,
    String? localizedReason,
    bool biometricOnly = false,
    bool stickyAuth = true,
    bool sensitiveTransaction = true,
  }) async {
    return await _localAuth.authenticate(
      localizedReason: localizedReason ?? reason,
      options: AuthenticationOptions(
        biometricOnly: biometricOnly,
        stickyAuth: stickyAuth,
        sensitiveTransaction: sensitiveTransaction,
      ),
    );
  }

  Future<bool> stopAuthentication() async {
    return await _localAuth.stopAuthentication();
  }
}
