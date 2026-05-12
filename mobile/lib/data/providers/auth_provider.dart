// 认证状态管理 - Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../../core/network/token_manager.dart';
import '../models/auth_models.dart';
import '../repositories/auth_repository.dart';
import 'providers.dart';

/// 认证状态
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
  error,
}

class AuthState {
  final AuthStatus status;
  final UserInfo? userInfo;
  final String? error;
  final String? masterPassword;

  AuthState({
    this.status = AuthStatus.initial,
    this.userInfo,
    this.error,
    this.masterPassword,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;

  AuthState copyWith({
    AuthStatus? status,
    UserInfo? userInfo,
    String? error,
    String? masterPassword,
  }) {
    return AuthState(
      status: status ?? this.status,
      userInfo: userInfo ?? this.userInfo,
      error: error,
      masterPassword: masterPassword ?? this.masterPassword,
    );
  }
}

/// 认证状态管理器
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final TokenManager _tokenManager = TokenManager();

  AuthNotifier(this._repository) : super(AuthState()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final hasToken = await _repository.hasValidSession();
      final masterPassword = await _tokenManager.getMasterPassword();

      if (hasToken && masterPassword != null && masterPassword.isNotEmpty) {
        await ApiClient.instance.setMasterPassword(masterPassword);
        state = state.copyWith(
          status: AuthStatus.authenticated,
          masterPassword: masterPassword,
        );
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final user = await _repository.register(RegisterRequest(
        email: email,
        password: password,
        passwordConfirm: password,
      ));
      await ApiClient.instance.setMasterPassword(password);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        userInfo: user,
        masterPassword: password,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e is ApiException ? e.message : e.toString(),
      );
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _repository.login(LoginRequest(
        email: email,
        password: password,
      ));
      await ApiClient.instance.setMasterPassword(password);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        masterPassword: password,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e is ApiException ? e.message : e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    await ApiClient.instance.clearMasterPassword();
    state = AuthState(status: AuthStatus.unauthenticated);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// 认证 Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
