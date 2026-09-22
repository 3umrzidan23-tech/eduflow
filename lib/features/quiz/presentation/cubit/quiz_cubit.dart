import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/quiz_repository.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository _repository;

  QuizCubit({QuizRepository? repository})
      : _repository = repository ?? QuizRepositoryImpl(),
        super(QuizInitial());

  Future<void> loadQuiz(String courseId) async {
    emit(QuizLoading());
    try {
      final quiz = await _repository.getQuizForCourse(courseId);
      emit(QuizLoaded(quiz: quiz));
    } catch (e) {
      emit(QuizFailure(message: 'Failed to load quiz: ${e.toString()}'));
    }
  }

  void selectAnswer(String questionId, int optionIndex) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      if (currentState.isSubmitted) return; // Prevent changing answer after submit

      final newAnswers = Map<String, int>.from(currentState.selectedAnswers);
      newAnswers[questionId] = optionIndex;
      emit(currentState.copyWith(selectedAnswers: newAnswers));
    }
  }

  void submitQuiz() {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      if (currentState.isSubmitted) return;

      int score = 0;
      for (var question in currentState.quiz.questions) {
        final selected = currentState.selectedAnswers[question.id];
        if (selected == question.correctOptionIndex) {
          score++;
        }
      }

      emit(currentState.copyWith(isSubmitted: true, score: score));
    }
  }
}
