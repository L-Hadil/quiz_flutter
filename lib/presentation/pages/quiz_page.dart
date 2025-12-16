import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/quiz_data_provider.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/questions_card.dart';

class QuizPageProvider extends StatelessWidget {
  const QuizPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz avec Provider'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<QuizProvider>().resetQuiz(),
          ),
        ],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.questions.isEmpty) {
            return const Center(child: Text('Aucune question disponible'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                QuizProgressIndicator(
                  current: provider.currentQuestionIndex + 1,
                  total: provider.totalQuestions,
                  progress: provider.progress,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: QuestionCard(
                    question: provider.currentQuestion,
                    onAnswerSelected: (index) {
                      provider.answerQuestion(index);

                      if (provider.currentQuestionIndex == provider.totalQuestions - 1) {
                        _showResultsDialog(context, provider.score, provider.totalQuestions);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showResultsDialog(BuildContext context, int score, int total) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Terminé!'),
        content: Text('Votre score: $score/$total'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<QuizProvider>().resetQuiz();
            },
            child: const Text('Recommencer'),
          ),
        ],
      ),
    );
  }
}