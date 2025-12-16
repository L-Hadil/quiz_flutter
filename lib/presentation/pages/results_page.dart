import 'package:flutter/material.dart';
import '../../data/models/quiz_result.dart';

class ResultsPage extends StatelessWidget {
  final QuizResult quizResult;
  const ResultsPage({super.key, required this.quizResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats du Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScoreCard(context),
            const SizedBox(height: 24),
            _buildDetailsCard(context),
            const SizedBox(height: 24),
            _buildQuestionResults(context),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Score Final',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('${quizResult.score}/${quizResult.totalQuestions}',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: quizResult.score / quizResult.totalQuestions,
              backgroundColor: Colors.grey.shade300,
              minHeight: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text('${quizResult.percentage.toStringAsFixed(1)}%',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Détails',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildDetailRow(
                context: context,
                icon: Icons.calendar_today,
                label: 'Date',
                value: quizResult.formattedDate),
            _buildDetailRow(
                context: context,
                icon: Icons.timer,
                label: 'Durée',
                value: quizResult.formattedDuration),
            _buildDetailRow(
                context: context,
                icon: Icons.question_answer,
                label: 'Questions',
                value: '${quizResult.totalQuestions} questions'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      {required BuildContext context,
        required IconData icon,
        required String label,
        required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionResults(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Détail des Réponses',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...quizResult.questionResults.asMap().entries.map((entry) {
          final index = entry.key;
          final result = entry.value;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 8),
                  Text(result.questionText,
                      style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                          result.isCorrect ? Icons.check : Icons.close,
                          color: result.isCorrect ? Colors.green : Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Votre réponse: ${result.selectedAnswer}',
                                style: TextStyle(
                                    color: result.isCorrect
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.w500)),
                            if (!result.isCorrect)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text('Bonne réponse: ${result.correctAnswer}',
                                    style: const TextStyle(color: Colors.green)),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
