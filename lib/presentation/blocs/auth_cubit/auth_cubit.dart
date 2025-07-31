import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/get_current_user_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/login_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/register_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/sign_out_usecase.dart';
import 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getCurrentUserUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(name, email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    try {
      final user = await getCurrentUserUseCase();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await signOutUseCase();
    emit(AuthLoggedOut());
  }
}
