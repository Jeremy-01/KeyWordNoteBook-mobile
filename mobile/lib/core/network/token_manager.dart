// Token 管理器 - 使用 flutter_secure_storage 安全存储
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Token 存储键
class TokenKeys {
  TokenKeys._();

  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiry = 'token_expiry';
  static const String masterPassword = 'master_password';
}

/// Token 管理器
class TokenManager {
  final FlutterSecureStorage _storage;

  TokenManager({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock,
          ),
        );

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: TokenKeys.accessToken, value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: TokenKeys.refreshToken, value: token);
  }

  Future<void> saveTokenExpiry(DateTime expiry) async {
    await _storage.write(
      key: TokenKeys.tokenExpiry,
      value: expiry.toIso8601String(),
    );
  }

  Future<void> saveMasterPassword(String password) async {
    await _storage.write(key: TokenKeys.masterPassword, value: password);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: TokenKeys.accessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: TokenKeys.refreshToken);
  }

  Future<DateTime?> getTokenExpiry() async {
    final expiry = await _storage.read(key: TokenKeys.tokenExpiry);
    if (expiry == null) return null;
    return DateTime.tryParse(expiry);
  }

  Future<String?> getMasterPassword() async {
    return await _storage.read(key: TokenKeys.masterPassword);
  }

  Future<void> clearMasterPassword() async {
    await _storage.delete(key: TokenKeys.masterPassword);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: TokenKeys.accessToken);
    await _storage.delete(key: TokenKeys.refreshToken);
    await _storage.delete(key: TokenKeys.tokenExpiry);
    await clearMasterPassword();
  }

  Future<bool> hasValidToken() async {
    final token = await getAccessToken();
    if (token == null) return false;

    final expiry = await getTokenExpiry();
    if (expiry != null && expiry.isBefore(DateTime.now())) {
      return false;
    }
    return true;
  }
}
