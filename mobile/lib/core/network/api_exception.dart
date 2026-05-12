import 'package:dio/dio.dart';

/// API 异常定义
class ApiException implements Exception {
  final int code;
  final String message;
  final int? statusCode;

  ApiException({
    required this.code,
    required this.message,
    this.statusCode,
  });

  factory ApiException.fromDioError(dynamic error, int? statusCode) {
    if (error is DioException) {
      final resolvedStatusCode = statusCode ?? error.response?.statusCode;
      return ApiException(
        code: _mapStatusToCode(resolvedStatusCode),
        message: _extractMessage(error) ??
            error.message ??
            _getDefaultMessage(resolvedStatusCode),
        statusCode: resolvedStatusCode,
      );
    }
    return ApiException(
      code: _mapStatusToCode(statusCode),
      message: error.toString(),
      statusCode: statusCode,
    );
  }

  static int _mapStatusToCode(int? statusCode) {
    return switch (statusCode) {
      400 => 1001,
      401 => 1002,
      422 => 1001,
      403 => 1004,
      404 => 2001,
      409 => 2002,
      500 => 5001,
      _ => 5001,
    };
  }

  static String _getDefaultMessage(int? statusCode) {
    return switch (statusCode) {
      400 => '请求参数错误',
      401 => '认证失败或 Token 已过期',
      422 => '请求参数错误',
      403 => '权限不足',
      404 => '资源不存在',
      409 => '资源冲突',
      500 => '服务器内部错误',
      _ => '网络请求失败',
    };
  }

  static String? _extractMessage(DioException error) {
    final data = error.response?.data;
    if (data is Map) {
      final detail = data['detail'];
      final detailMessage = _extractDetail(detail);
      if (detailMessage != null) {
        return detailMessage;
      }

      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }
    }

    return null;
  }

  static String? _extractDetail(dynamic detail) {
    if (detail is String && detail.trim().isNotEmpty) {
      return detail.trim();
    }

    if (detail is List) {
      final messages = detail.map((item) {
        if (item is Map) {
          final loc = item['loc'];
          final msg = item['msg'];
          if (loc is List &&
              loc.length >= 2 &&
              loc[0] == 'header' &&
              loc[1] == 'x-verify-password' &&
              msg == 'Field required') {
            return '需要二次密码验证';
          }
          if (msg is String && msg.trim().isNotEmpty) {
            return msg.trim();
          }
        }
        if (item is String && item.trim().isNotEmpty) {
          return item.trim();
        }
        return null;
      }).whereType<String>().toList();

      if (messages.isNotEmpty) {
        return messages.join('；');
      }
    }

    return null;
  }

  @override
  String toString() => 'ApiException(code: $code, message: $message, statusCode: $statusCode)';
}

/// Token 过期异常
class TokenExpiredException extends ApiException {
  TokenExpiredException() : super(
    code: 1003,
    message: 'Token 已过期，请重新登录',
    statusCode: 401,
  );
}
