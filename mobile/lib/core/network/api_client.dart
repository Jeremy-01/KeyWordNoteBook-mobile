// API 客户端 - 基于 Dio
import 'dart:convert';

import 'package:dio/dio.dart';

import '../constants/api_endpoints.dart';
import 'api_response.dart';
import 'api_exception.dart';
import 'token_manager.dart';
import '../constants/app_constants.dart';

const _skipTokenRefreshKey = 'skipTokenRefresh';
const _verifyPasswordHeader = 'X-Verify-Password';
const _redactedValue = '***';
const _sensitiveLogKeys = {
  'password',
  'password_confirm',
  'refresh_token',
  'access_token',
  'master_password',
  'x-verify-password',
};

bool shouldAttemptTokenRefresh(RequestOptions options) {
  if (options.extra[_skipTokenRefreshKey] == true) {
    return false;
  }

  final path = options.path;
  return !path.endsWith(ApiEndpoints.login) &&
      !path.endsWith(ApiEndpoints.register) &&
      !path.endsWith(ApiEndpoints.refresh);
}

bool requiresMasterPassword(RequestOptions options) {
  final method = options.method.toUpperCase();
  final path = options.path;

  if (path == ApiEndpoints.keybookItems) {
    return method != 'GET';
  }

  return path.startsWith('${ApiEndpoints.keybookItems}/');
}

dynamic sanitizeLogData(dynamic data) {
  if (data is Map) {
    return data.map((key, value) {
      final keyString = key.toString();
      final normalizedKey = keyString.toLowerCase();
      final sanitizedValue = _sensitiveLogKeys.contains(normalizedKey)
          ? _redactedValue
          : sanitizeLogData(value);
      return MapEntry(key, sanitizedValue);
    });
  }

  if (data is Iterable) {
    return data.map(sanitizeLogData).toList(growable: false);
  }

  return data;
}

/// API 客户端单例
class ApiClient {
  static ApiClient? _instance;
  static ApiClient get instance => _instance ??= ApiClient._();

  late final Dio _dio;
  final TokenManager _tokenManager;

  ApiClient._({
    TokenManager? tokenManager,
    String? baseUrl,
  }) : _tokenManager = tokenManager ?? TokenManager() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onError: _onError,
    ));
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenManager.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (!requiresMasterPassword(options)) {
      options.headers.remove(_verifyPasswordHeader);
    } else if (!options.headers.containsKey(_verifyPasswordHeader)) {
      final masterPassword = await _tokenManager.getMasterPassword();
      if (masterPassword != null && masterPassword.isNotEmpty) {
        options.headers[_verifyPasswordHeader] = masterPassword;
      }
    }

    if (AppConstants.debug) {
      print('[API] ${options.method} ${options.uri}');
      if (options.data != null) {
        print('[API] Body: ${jsonEncode(sanitizeLogData(options.data))}');
      }
    }

    handler.next(options);
  }

  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    if (AppConstants.debug) {
      print('[API Error] ${error.message}');
    }

    if (error.response?.statusCode == 401 &&
        shouldAttemptTokenRefresh(error.requestOptions)) {
      final refreshed = await _tryRefreshToken();
      if (refreshed) {
        final response = await _retry(error.requestOptions);
        return handler.resolve(response);
      }
    }

    handler.next(error);
  }

  Future<bool> _tryRefreshToken() async {
    try {
      final refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(
          headers: {},
          extra: {_skipTokenRefreshKey: true},
        ),
      );

      if (response.statusCode == 200 && response.data['code'] == 0) {
        final newAccess = response.data['data']['access_token'];
        await _tokenManager.saveAccessToken(newAccess);
        return true;
      }
    } catch (e) {
      await _tokenManager.clearTokens();
    }
    return false;
  }

  Future<Response> _retry(RequestOptions options) async {
    final token = await _tokenManager.getAccessToken();
    options.headers['Authorization'] = 'Bearer $token';
    options.extra[_skipTokenRefreshKey] = true;
    return _dio.fetch(options);
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        fromJsonT,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e, e.response?.statusCode);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        fromJsonT,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e, e.response?.statusCode);
    }
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        fromJsonT,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e, e.response?.statusCode);
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String path, {
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final response = await _dio.delete(path);
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        fromJsonT,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e, e.response?.statusCode);
    }
  }

  Future<void> setMasterPassword(String password) async {
    await _tokenManager.saveMasterPassword(password);
  }

  Future<void> clearMasterPassword() async {
    _dio.options.headers.remove('X-Verify-Password');
    await _tokenManager.clearMasterPassword();
  }

  Future<void> clearAuth() async {
    await _tokenManager.clearTokens();
    _dio.options.headers.remove('X-Verify-Password');
  }
}

/// 便捷方法扩展
extension ApiClientExtension on ApiClient {
  Future<ApiResponse<T>> getT<T>(String path, {
    Map<String, dynamic>? params,
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    return get<T>(
      path,
      queryParameters: params,
      fromJsonT: fromJson != null ? (d) => fromJson(d as Map<String, dynamic>) : null,
    );
  }

  Future<ApiResponse<T>> postT<T>(String path, {
    Map<String, dynamic>? data,
    T Function(Map<String, dynamic>)? fromJson,
  }) {
    return post<T>(
      path,
      data: data,
      fromJsonT: fromJson != null ? (d) => fromJson(d as Map<String, dynamic>) : null,
    );
  }
}
