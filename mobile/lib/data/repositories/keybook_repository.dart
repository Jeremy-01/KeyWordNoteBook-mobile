// 密码本仓库 - 处理密码条目相关的 API 调用
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../../core/network/api_response.dart';
import '../../core/constants/api_endpoints.dart';
import '../models/key_item_model.dart';
import '../models/sync_models.dart';

/// 密码本仓库
class KeyBookRepository {
  final ApiClient _apiClient;

  KeyBookRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient.instance;

  Future<PaginatedResponse<KeyItemModel>> getItems({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.keybookItems,
      queryParameters: {'page': page, 'page_size': pageSize},
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return PaginatedResponse.fromJson(
      response.data!,
      KeyItemModel.fromJson,
    );
  }

  Future<KeyItemModel> getItemDetail(String itemId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.keybookItem(itemId),
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return KeyItemModel.fromJson(response.data!);
  }

  Future<String> addItem(KeyItemModel item) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.keybookItems,
      data: item.toJson(),
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return response.data!['item_id']?.toString() ?? '';
  }

  Future<void> updateItem(String itemId, KeyItemModel item) async {
    final response = await _apiClient.put<Map<String, dynamic>>(
      ApiEndpoints.keybookItem(itemId),
      data: item.toJson(),
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }
  }

  Future<void> deleteItem(String itemId) async {
    final response = await _apiClient.delete<Map<String, dynamic>>(
      ApiEndpoints.keybookItem(itemId),
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }
  }

  Future<SyncStatus> getSyncStatus(int clientVersion) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      ApiEndpoints.syncStatus,
      queryParameters: {'client_version': clientVersion},
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return SyncStatus.fromJson(response.data!);
  }

  Future<SyncPushResponse> pushChanges(SyncPushRequest request) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.syncPush,
      data: request.toJson(),
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return SyncPushResponse.fromJson(response.data!);
  }

  Future<SyncPullResponse> pullChanges(int clientVersion) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.syncPull,
      data: {'client_version': clientVersion},
    );

    if (!response.isSuccess) {
      throw ApiException(
        code: response.code,
        message: response.message,
      );
    }

    return SyncPullResponse.fromJson(response.data!);
  }
}
