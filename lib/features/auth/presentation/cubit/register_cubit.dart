import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepositoryImpl(),
        super(RegisterInitial());

  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      await _authRepository.registerWithEmailAndPassword(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during registration.';
      if (e.code == 'email-already-in-use') {
        message = 'This email address is already in use.';
      } else if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      }
      emit(RegisterFailure(message: message));
    } catch (e) {
      emit(RegisterFailure(message: e.toString()));
    }
  }
}
