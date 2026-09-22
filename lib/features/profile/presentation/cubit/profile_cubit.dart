import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileCubit() : super(ProfileInitial());

  void loadProfile() {
    emit(ProfileLoading());
    try {
      final user = _auth.currentUser;
      if (user != null) {
        emit(ProfileLoaded(
          name: user.displayName ?? 'Student User',
          email: user.email ?? 'student@example.com',
        ));
      } else {
        emit(const ProfileFailure(message: 'User not found'));
      }
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      emit(ProfileLoggedOut());
    } catch (e) {
      emit(ProfileFailure(message: 'Logout failed: ${e.toString()}'));
    }
  }
}
