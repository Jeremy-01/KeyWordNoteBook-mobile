// 认证状态管理 - Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../../core/network/token_manager.dart';
import '../models/auth_models.dart';
import '../repositories/auth_repository.dart';
import 'providers.dart';

const _errorNotProvided = Object();

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
  final bool isCheckingSession;
  final bool isSubmitting;

  AuthState({
    this.status = AuthStatus.initial,
    this.userInfo,
    this.error,
    this.masterPassword,
    this.isCheckingSession = false,
    this.isSubmitting = false,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => isCheckingSession || isSubmitting;

  AuthState copyWith({
    AuthStatus? status,
    UserInfo? userInfo,
    Object? error = _errorNotProvided,
    String? masterPassword,
    bool? isCheckingSession,
    bool? isSubmitting,
  }) {
    return AuthState(
      status: status ?? this.status,
      userInfo: userInfo ?? this.userInfo,
      error: identical(error, _errorNotProvided) ? this.error : error as String?,
      masterPassword: masterPassword ?? this.masterPassword,
      isCheckingSession: isCheckingSession ?? this.isCheckingSession,
      isSubmitting: isSubmitting ?? this.isSubmitting,
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
    state = state.copyWith(isCheckingSession: true, error: null);
    try {
      final hasToken = await _repository.hasValidSession();
      final masterPassword = await _tokenManager.getMasterPassword();

      if (hasToken && masterPassword != null && masterPassword.isNotEmpty) {
        await ApiClient.instance.setMasterPassword(masterPassword);
        state = state.copyWith(
          status: AuthStatus.authenticated,
          masterPassword: masterPassword,
          isCheckingSession: false,
          error: null,
        );
      } else {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          isCheckingSession: false,
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isCheckingSession: false,
        error: null,
      );
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      final user = await _repository.register(RegisterRequest(
        email: email,
        password: password,
        passwordConfirm: password,
      ));
      await _repository.login(LoginRequest(
        email: email,
        password: password,
      ));
      await ApiClient.instance.setMasterPassword(password);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        userInfo: user,
        masterPassword: password,
        isSubmitting: false,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isSubmitting: false,
        error: e is ApiException ? e.message : e.toString(),
      );
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isSubmitting: true, error: null);
    try {
      await _repository.login(LoginRequest(
        email: email,
        password: password,
      ));
      await ApiClient.instance.setMasterPassword(password);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        masterPassword: password,
        isSubmitting: false,
        error: null,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isSubmitting: false,
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
