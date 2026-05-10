/// API 统一响应模型
class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
  });

  bool get isSuccess => code == 0;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? 'success',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data,
  };
}

/// 分页响应
class PaginatedResponse<T> {
  final List<T> items;
  final int total;
  final int page;
  final int pageSize;

  PaginatedResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  int get totalPages => (total / pageSize).ceil();
  bool get hasMore => page < totalPages;

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      items: (json['items'] as List?)
          ?.map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList() ?? [],
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['page_size'] ?? 20,
    );
  }
}
