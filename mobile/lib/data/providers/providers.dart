/// Riverpod Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/auth_repository.dart';
import '../repositories/keybook_repository.dart';
import '../core/network/token_manager.dart';
import 'settings_provider.dart';

export 'settings_provider.dart' show settingsProvider, localStorageProvider, biometricServiceProvider, syncServiceProvider;

final tokenManagerProvider = Provider<TokenManager>((ref) {
  return TokenManager();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final keyBookRepositoryProvider = Provider<KeyBookRepository>((ref) {
  return KeyBookRepository();
});
