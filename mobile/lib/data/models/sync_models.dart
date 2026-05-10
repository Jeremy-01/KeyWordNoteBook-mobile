/// 同步相关模型

/// 同步状态
class SyncStatus {
  final int localVersion;
  final int serverVersion;
  final DateTime? lastSyncTime;
  final bool needSync;

  SyncStatus({
    required this.localVersion,
    required this.serverVersion,
    this.lastSyncTime,
    required this.needSync,
  });

  factory SyncStatus.fromJson(Map<String, dynamic> json) {
    return SyncStatus(
      localVersion: json['local_version'] ?? 0,
      serverVersion: json['server_version'] ?? 0,
      lastSyncTime: json['last_sync_time'] != null
          ? DateTime.tryParse(json['last_sync_time'])
          : null,
      needSync: json['need_sync'] ?? false,
    );
  }
}

/// 同步操作
class SyncOperation {
  final String op;
  final String itemId;
  final Map<String, dynamic>? data;

  SyncOperation({
    required this.op,
    required this.itemId,
    this.data,
  });

  Map<String, dynamic> toJson() => {
    'op': op,
    'item_id': itemId,
    if (data != null) 'data': data,
  };
}

/// 同步推送请求
class SyncPushRequest {
  final int clientVersion;
  final List<SyncOperation> operations;

  SyncPushRequest({
    required this.clientVersion,
    required this.operations,
  });

  Map<String, dynamic> toJson() => {
    'client_version': clientVersion,
    'operations': operations.map((o) => o.toJson()).toList(),
  };
}

/// 同步推送响应
class SyncPushResponse {
  final int serverVersion;
  final List<dynamic> conflicts;

  SyncPushResponse({
    required this.serverVersion,
    required this.conflicts,
  });

  factory SyncPushResponse.fromJson(Map<String, dynamic> json) {
    return SyncPushResponse(
      serverVersion: json['server_version'] ?? 0,
      conflicts: json['conflicts'] ?? [],
    );
  }
}

/// 同步拉取响应
class SyncPullResponse {
  final int serverVersion;
  final List<SyncOperation> operations;

  SyncPullResponse({
    required this.serverVersion,
    required this.operations,
  });

  factory SyncPullResponse.fromJson(Map<String, dynamic> json) {
    return SyncPullResponse(
      serverVersion: json['server_version'] ?? 0,
      operations: (json['operations'] as List?)
          ?.map((o) => SyncOperation(
                op: o['op'] ?? '',
                itemId: o['item_id'] ?? '',
                data: o['data'],
              ))
          .toList() ?? [],
    );
  }
}
