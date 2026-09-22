import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepositoryImpl(),
        super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _authRepository.loginWithEmailAndPassword(email.trim(), password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (email.trim() == 'demo@eduflow.com' &&
          (e.code == 'user-not-found' || e.code == 'invalid-credential' || e.code == 'wrong-password')) {
        // Automatically register the demo account if it doesn't exist
        try {
          await _authRepository.registerWithEmailAndPassword(
            fullName: 'Omar Ahmed',
            email: 'demo@eduflow.com',
            phone: '1234567890',
            password: 'demo123456',
          );
          emit(LoginSuccess());
          return;
        } catch (registerError) {
          emit(LoginFailure(message: 'Failed to initialize demo account.'));
          return;
        }
      }

      String message = 'An error occurred during login.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid email or password.';
      }
      emit(LoginFailure(message: message));
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }

  void useDemoAccount() {
    login('demo@eduflow.com', 'demo123456');
  }
}
