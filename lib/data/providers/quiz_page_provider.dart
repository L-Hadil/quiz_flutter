import 'package:flutter/material.dart';
import 'package:flutter_quiz_advanced/data/providers/quiz_data_provider.dart';
import 'package:provider/provider.dart';
import '../../data/models/question.dart';

class QuizPageProvider extends StatelessWidget {
  const QuizPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Provider'),
        centerTitle: true,
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quiz, child) {
          if (quiz.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Toutes les questions ont été répondues
          if (quiz.currentQuestionIndex >= quiz.totalQuestions) {
            return _buildResult(context, quiz);
          }

          return _buildQuestion(context, quiz);
        },
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, QuizProvider quiz) {
    if (quiz.questions.isEmpty) {
      return const Center(child: Text('Aucune question disponible'));
    }

    Question question = quiz.currentQuestion;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LinearProgressIndicator(
            value: quiz.progress.clamp(0.0, 1.0),
            color: Colors.blue,
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            question.text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (question.imageUrl?.isNotEmpty ?? false)
            Image.network(question.imageUrl!, height: 200, fit: BoxFit.cover),
          const SizedBox(height: 16),
          ...List.generate(
            question.answers.length,
                (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ElevatedButton(
                onPressed: () {
                  quiz.answerQuestion(index);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.blue[50],
                  foregroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  question.answers[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult(BuildContext context, QuizProvider quiz) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz terminé !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Votre score : ${quiz.score} / ${quiz.totalQuestions}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => quiz.resetQuiz(),
              child: const Text('Recommencer'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}
