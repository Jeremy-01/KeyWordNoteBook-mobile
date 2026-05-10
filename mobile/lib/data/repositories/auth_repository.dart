/// 认证仓库 - 处理认证相关的 API 调用
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../../core/network/api_response.dart';
import '../../core/constants/api_endpoints.dart';
import '../models/auth_models.dart';

/// 认证仓库
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;

  Future<UserInfo> register(RegisterRequest request) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.register,
      data: request.toJson(),
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return UserInfo.fromJson(response.data!);
  }

  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return AuthResponse.fromJson(response.data!);
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.refresh,
      data: RefreshRequest(refreshToken: refreshToken).toJson(),
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return AuthResponse.fromJson(response.data!);
  }

  Future<void> logout() async {
    await _apiClient.clearAuth();
  }
}
