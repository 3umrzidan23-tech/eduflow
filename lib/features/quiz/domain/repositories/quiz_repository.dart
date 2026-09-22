import '../entities/quiz.dart';

abstract class QuizRepository {
  Future<Quiz> getQuizForCourse(String courseId);
}

class QuizRepositoryImpl implements QuizRepository {
  @override
  Future<Quiz> getQuizForCourse(String courseId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return Quiz(
      id: 'q1',
      courseId: courseId,
      title: 'Midterm Quiz',
      questions: [
        QuizQuestion(
          id: 'qq1',
          questionText: 'What is the main purpose of Flutter?',
          options: [
            'Building web servers',
            'Cross-platform UI development',
            'Database management',
            'Game engine development',
          ],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          id: 'qq2',
          questionText: 'Which language is used in Flutter?',
          options: [
            'Java',
            'Kotlin',
            'Dart',
            'Swift',
          ],
          correctOptionIndex: 2,
        ),
        QuizQuestion(
          id: 'qq3',
          questionText: 'What is a widget in Flutter?',
          options: [
            'A database table',
            'An immutable description of part of a user interface',
            'A background service',
            'A build tool',
          ],
          correctOptionIndex: 1,
        ),
      ],
    );
  }
}
