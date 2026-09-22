import 'package:equatable/equatable.dart';
import '../../domain/entities/quiz.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final Quiz quiz;
  final Map<String, int> selectedAnswers; // questionId -> optionIndex
  final bool isSubmitted;
  final int score;

  const QuizLoaded({
    required this.quiz,
    this.selectedAnswers = const {},
    this.isSubmitted = false,
    this.score = 0,
  });

  QuizLoaded copyWith({
    Quiz? quiz,
    Map<String, int>? selectedAnswers,
    bool? isSubmitted,
    int? score,
  }) {
    return QuizLoaded(
      quiz: quiz ?? this.quiz,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [quiz, selectedAnswers, isSubmitted, score];
}

class QuizFailure extends QuizState {
  final String message;

  const QuizFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
