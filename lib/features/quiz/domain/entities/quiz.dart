class Quiz {
  final String id;
  final String courseId;
  final String title;
  final List<QuizQuestion> questions;

  Quiz({
    required this.id,
    required this.courseId,
    required this.title,
    required this.questions,
  });
}

class QuizQuestion {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}
