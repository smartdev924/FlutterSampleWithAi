import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(const AuthLoadInProgress());
    final signedIn = await _authService.restoreSession();
    if (signedIn && _authService.currentUser != null) {
      emit(AuthAuthenticated(user: _authService.currentUser!));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoadInProgress());
    try {
      final success = await _authService.login(event.email, event.password);
      if (success && _authService.currentUser != null) {
        emit(AuthAuthenticated(user: _authService.currentUser!));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (error) {
      final message = error is ApiException ? error.message : error.toString();
      emit(AuthFailure(message));
    }
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _authService.logout();
    emit(const AuthUnauthenticated());
  }
}
