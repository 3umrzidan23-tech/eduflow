class HomeData {
  final String studentName;
  final String? profilePictureUrl;
  final int overallProgress;
  final CourseProgressData? continueLearning;
  final String? upcomingAssignment;
  final String? nextClass;
  final QuizResultData? recentQuiz;

  HomeData({
    required this.studentName,
    this.profilePictureUrl,
    required this.overallProgress,
    this.continueLearning,
    this.upcomingAssignment,
    this.nextClass,
    this.recentQuiz,
  });
}

class CourseProgressData {
  final String courseName;
  final int progressPercentage;

  CourseProgressData({
    required this.courseName,
    required this.progressPercentage,
  });
}

class QuizResultData {
  final String quizName;
  final int score;
  final int total;
  final int percentage;

  QuizResultData({
    required this.quizName,
    required this.score,
    required this.total,
    required this.percentage,
  });
}
