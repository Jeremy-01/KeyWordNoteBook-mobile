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
      return ApiException(
        code: _mapStatusToCode(statusCode ?? error.response?.statusCode),
        message: error.message ?? _getDefaultMessage(statusCode ?? error.response?.statusCode),
        statusCode: statusCode ?? error.response?.statusCode,
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
      403 => '权限不足',
      404 => '资源不存在',
      409 => '资源冲突',
      500 => '服务器内部错误',
      _ => '网络请求失败',
    };
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

/// Dio 导入占位
class DioException implements Exception {
  final String? message;
  final int? statusCode;
  final dynamic response;

  DioException({this.message, this.statusCode, this.response});
}
