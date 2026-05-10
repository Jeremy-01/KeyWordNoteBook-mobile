class SyncState {
  final int localVersion;
  final int serverVersion;
  final SyncStatus status;
  final bool isSyncing;
  final bool autoSyncEnabled;
  final DateTime? lastSyncTime;
  final String? errorMessage;

  SyncState({
    required this.localVersion,
    required this.serverVersion,
    required this.status,
    required this.isSyncing,
    required this.autoSyncEnabled,
    this.lastSyncTime,
    this.errorMessage,
  });

  bool get needSync => localVersion < serverVersion;

  factory SyncState.initial() {
    return SyncState(
      localVersion: 0,
      serverVersion: 0,
      status: SyncStatus.idle,
      isSyncing: false,
      autoSyncEnabled: false,
    );
  }

  SyncState copyWith({
    int? localVersion,
    int? serverVersion,
    SyncStatus? status,
    bool? isSyncing,
    bool? autoSyncEnabled,
    DateTime? lastSyncTime,
    String? errorMessage,
  }) {
    return SyncState(
      localVersion: localVersion ?? this.localVersion,
      serverVersion: serverVersion ?? this.serverVersion,
      status: status ?? this.status,
      isSyncing: isSyncing ?? this.isSyncing,
      autoSyncEnabled: autoSyncEnabled ?? this.autoSyncEnabled,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum SyncStatus {
  idle,
  syncing,
  success,
  error,
  conflict,
}
