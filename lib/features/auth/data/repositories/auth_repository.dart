import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthRepository {
  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
  Future<UserCredential> registerWithEmailAndPassword({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> registerWithEmailAndPassword({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Save to Firestore
    if (userCredential.user != null) {
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });
      // Optionally update the display name
      await userCredential.user!.updateDisplayName(fullName);
    }

    return userCredential;
  }
}

