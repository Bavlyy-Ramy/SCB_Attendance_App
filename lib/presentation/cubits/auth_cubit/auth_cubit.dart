import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_attendance_app/domain/entities/user_entity.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/get_current_user_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/login_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/register_usecase.dart';
import 'package:scb_attendance_app/domain/usecases/auth%20usecases/sign_out_usecase.dart';
import 'package:scb_attendance_app/presentation/pages/widgets/helper.dart';
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
  } on FirebaseAuthException catch (e) {
    emit(AuthError(getFriendlyErrorMessage(e))); // ✅ friendly error
  } catch (e) {
    emit(AuthError("Something went wrong. Please try again."));
  }
}


  Future<UserEntity?> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(name, email, password, role);
      emit(AuthAuthenticated(user));
      return user; // ✅ return user
    } catch (e) {
      emit(AuthError(e.toString()));
      return null;
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

  Future<void> makeUserAdmin(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'role': 'admin',
    });
  }
}
