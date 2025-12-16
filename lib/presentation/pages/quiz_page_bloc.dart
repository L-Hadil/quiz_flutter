import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/quiz_bloc.dart';
import '../../business_logic/blocs/quiz_event.dart';

import '../../business_logic/blocs/quiz_state.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/questions_card.dart';

class QuizPageBloc extends StatelessWidget {
  const QuizPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz avec BLoC'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<QuizBloc>().add(ResetQuizEvent()),
          ),
        ],
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuizError) {
            return Center(child: Text(state.message));
          }

          if (state is QuizLoaded) {
            if (state.questions.isEmpty) {
              return const Center(child: Text('Aucune question disponible'));
            }

            if (state.showResults) {
              return _buildResults(context, state);
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  QuizProgressIndicator(
                    current: state.currentQuestionIndex + 1,
                    total: state.totalQuestions,
                    progress: state.progress,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: QuestionCard(
                      question: state.currentQuestion,
                      onAnswerSelected: (index) {
                        context.read<QuizBloc>().add(AnswerQuestionEvent(index));
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildResults(BuildContext context, QuizLoaded state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quiz Terminé!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Votre score: ${state.score}/${state.totalQuestions}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.read<QuizBloc>().add(ResetQuizEvent());
            },
            child: const Text('Recommencer'),
          ),
        ],
      ),
    );
  }
}