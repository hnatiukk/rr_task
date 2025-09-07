import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rr_task/domain/usecases/auth_check_usecase.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthCheckUseCase authCheckUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.authCheckUseCase,
  }) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthChecked>(_onAuthChecked);
  }

  Future<void> _onAuthChecked(
    AuthChecked event,
    Emitter<AuthState> emit,
  ) async {
    final user = await authCheckUseCase.execute();
    if (user.token.isNotEmpty) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(event.email, event.password);
      emit(AuthAuthenticated(user: user));
    } on DioException catch (e) {
      emit(AuthFailure(e.response!.data['message']));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await logoutUseCase.execute();
      emit(AuthUnauthenticated());
    } on DioException catch (e) {
      emit(AuthFailure(e.response!.data['message']));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
