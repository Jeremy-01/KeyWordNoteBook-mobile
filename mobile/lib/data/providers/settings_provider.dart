import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/biometric/biometric_service.dart';
import '../../core/storage/local_storage.dart';
import '../../core/sync/sync_service.dart';

class SettingsStorageKeys {
  SettingsStorageKeys._();

  static const String autoLockMinutes = 'settings.auto_lock_minutes';
}

class SettingsStorage {
  Future<int?> getAutoLockMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SettingsStorageKeys.autoLockMinutes);
  }

  Future<void> saveAutoLockMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SettingsStorageKeys.autoLockMinutes, minutes);
  }
}

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
  SettingsNotifier(this._storage) : super(SettingsState()) {
    _loadPersistedSettings();
  }

  final SettingsStorage _storage;

  Future<void> _loadPersistedSettings() async {
    final autoLockMinutes = await _storage.getAutoLockMinutes();
    if (autoLockMinutes == null) {
      return;
    }

    state = state.copyWith(autoLockMinutes: autoLockMinutes);
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    state = state.copyWith(biometricEnabled: enabled);
  }

  Future<void> toggleBiometric() async {
    await setBiometricEnabled(!state.biometricEnabled);
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
    await _storage.saveAutoLockMinutes(minutes);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(ref.watch(settingsStorageProvider));
});

final settingsStorageProvider = Provider<SettingsStorage>((ref) {
  return SettingsStorage();
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
