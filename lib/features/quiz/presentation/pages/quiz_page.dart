import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/quiz_cubit.dart';
import '../cubit/quiz_state.dart';
import '../../domain/entities/quiz.dart';

class QuizPage extends StatelessWidget {
  final String courseId;

  const QuizPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..loadQuiz(courseId),
      child: const QuizView(),
    );
  }
}

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E293B)),
          onPressed: () => context.pop(),
        ),
        title: const Text('Quiz', style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading || state is QuizInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuizFailure) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
            } else if (state is QuizLoaded) {
              if (state.isSubmitted) {
                return _QuizResultView(
                  score: state.score,
                  totalQuestions: state.quiz.questions.length,
                );
              }
              return _QuizQuestionsView(
                quiz: state.quiz,
                selectedAnswers: state.selectedAnswers,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _QuizQuestionsView extends StatelessWidget {
  final Quiz quiz;
  final Map<String, int> selectedAnswers;

  const _QuizQuestionsView({required this.quiz, required this.selectedAnswers});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
          itemCount: quiz.questions.length,
          itemBuilder: (context, index) {
            final question = quiz.questions[index];
            final selectedOption = selectedAnswers[question.id];

            return Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${index + 1} of ${quiz.questions.length}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question.questionText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(question.options.length, (optionIndex) {
                    final isSelected = selectedOption == optionIndex;
                    return GestureDetector(
                      onTap: () {
                        context.read<QuizCubit>().selectAnswer(question.id, optionIndex);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue.withValues(alpha: 0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.blueAccent : Colors.grey.shade400,
                                ),
                                color: isSelected ? Colors.blueAccent : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                question.options[optionIndex],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? const Color(0xFF1E293B) : Colors.grey[700],
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
        Positioned(
          left: 24,
          right: 24,
          bottom: 24,
          child: ElevatedButton(
            onPressed: selectedAnswers.length == quiz.questions.length
                ? () {
                    context.read<QuizCubit>().submitQuiz();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Submit Quiz', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

class _QuizResultView extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const _QuizResultView({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions) * 100;
    final isPassed = percentage >= 50;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPassed ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
              ),
              child: Icon(
                isPassed ? Icons.emoji_events : Icons.sentiment_dissatisfied,
                size: 80,
                color: isPassed ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Your Score',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$score / $totalQuestions',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: isPassed ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPassed ? 'Congratulations! You passed the quiz.' : 'You failed. Please try again.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E293B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Back to Course', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
