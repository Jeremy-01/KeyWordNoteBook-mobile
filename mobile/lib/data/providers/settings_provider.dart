import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/local_storage.dart';
import '../biometric/biometric_service.dart';
import '../sync/sync_service.dart';

class SettingsState {
  final bool biometricEnabled;
  final bool autoSyncEnabled;
  final bool wifiOnlySync;
  final bool hidePasswords;
  final int autoLockMinutes;

  SettingsState({
    this.biometricEnabled = false,
    this.autoSyncEnabled = true,
    this.wifiOnlySync = false,
    this.hidePasswords = true,
    this.autoLockMinutes = 1,
  });

  SettingsState copyWith({
    bool? biometricEnabled,
    bool? autoSyncEnabled,
    bool? wifiOnlySync,
    bool? hidePasswords,
    int? autoLockMinutes,
  }) {
    return SettingsState(
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      autoSyncEnabled: autoSyncEnabled ?? this.autoSyncEnabled,
      wifiOnlySync: wifiOnlySync ?? this.wifiOnlySync,
      hidePasswords: hidePasswords ?? this.hidePasswords,
      autoLockMinutes: autoLockMinutes ?? this.autoLockMinutes,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState());

  Future<void> toggleBiometric() async {
    state = state.copyWith(biometricEnabled: !state.biometricEnabled);
  }

  Future<void> toggleAutoSync() async {
    state = state.copyWith(autoSyncEnabled: !state.autoSyncEnabled);
  }

  Future<void> toggleWifiOnlySync() async {
    state = state.copyWith(wifiOnlySync: !state.wifiOnlySync);
  }

  Future<void> toggleHidePasswords() async {
    state = state.copyWith(hidePasswords: !state.hidePasswords);
  }

  Future<void> setAutoLockDuration(int minutes) async {
    state = state.copyWith(autoLockMinutes: minutes);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

final localStorageProvider = Provider<LocalStorage>((ref) {
  throw UnimplementedError('LocalStorage must be overridden in ProviderScope');
});

final biometricServiceProvider = Provider<BiometricService>((ref) {
  return BiometricService();
});

final syncServiceProvider = Provider.family<SyncService, LocalStorage>((ref, storage) {
  return SyncService(localStorage: storage);
});
