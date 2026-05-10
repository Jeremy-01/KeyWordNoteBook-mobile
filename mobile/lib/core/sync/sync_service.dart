import 'dart:async';
import '../storage/local_storage.dart';
import '../storage/key_item.dart';
import 'sync_state.dart';

class SyncService {
  final LocalStorage localStorage;
  SyncState _state = SyncState.initial();
  Completer<void>? _syncCompleter;
  Timer? _autoSyncTimer;

  SyncService({required this.localStorage});

  Future<SyncState> getSyncState() async {
    final localVersion = await localStorage.getSyncVersion();
    return _state.copyWith(
      localVersion: localVersion,
      status: _state.status,
      isSyncing: _state.isSyncing,
    );
  }

  Completer<void> startSync() {
    _state = _state.copyWith(isSyncing: true, status: SyncStatus.syncing);
    _syncCompleter = Completer<void>();
    return _syncCompleter!;
  }

  Future<int> getPendingCount() async {
    final ops = await localStorage.getPendingOperations();
    return ops.length;
  }

  Future<void> clearPending() async {
    await localStorage.clearPendingOperations();
  }

  Future<void> pushChange(String type, KeyItem item) async {
    final op = PendingOperation(
      type: type,
      itemIndex: item.index,
      data: item.toMap(),
    );
    await localStorage.addPendingOperation(op);
  }

  Future<void> startAutoSync({required int intervalSeconds}) async {
    _state = _state.copyWith(autoSyncEnabled: true);
    _autoSyncTimer?.cancel();
    _autoSyncTimer = Timer.periodic(
      Duration(seconds: intervalSeconds),
      (_) => startSync().complete(null),
    );
  }

  Future<void> stopAutoSync() async {
    _autoSyncTimer?.cancel();
    _autoSyncTimer = null;
    _state = _state.copyWith(autoSyncEnabled: false);
  }

  Future<void> dispose() async {
    await stopAutoSync();
    _syncCompleter?.complete(null);
  }
}
