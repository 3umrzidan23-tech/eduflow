import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/home_data.dart';

abstract class HomeRepository {
  Future<HomeData> getHomeData();
}

class HomeRepositoryImpl implements HomeRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  HomeRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<HomeData> getHomeData() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    String studentName = 'Student';
    // Fetch user doc
    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        studentName = doc.data()?['fullName'] ?? 'Student';
      }
    } catch (e) {
      // Fallback to auth display name if firestore fails
      studentName = user.displayName ?? 'Student';
    }

    // Mock data for the dashboard until courses/assignments backend is ready
    return HomeData(
      studentName: studentName,
      overallProgress: 75,
      continueLearning: CourseProgressData(
        courseName: 'Flutter Development',
        progressPercentage: 73,
      ),
      upcomingAssignment: 'SQL Database Project',
      nextClass: 'Advanced Dart Concepts',
      recentQuiz: QuizResultData(
        quizName: 'Database Fundamentals',
        score: 8,
        total: 10,
        percentage: 80,
      ),
    );
  }
}
