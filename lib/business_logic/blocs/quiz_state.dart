import 'package:equatable/equatable.dart';
import '../../../data/models/question.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int score;
  final bool showResults;

  const QuizLoaded({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.showResults = false,
  });

  Question get currentQuestion => questions[currentQuestionIndex];
  int get totalQuestions => questions.length;
  double get progress => totalQuestions > 0 ? (currentQuestionIndex + 1) / totalQuestions : 0;

  @override
  List<Object?> get props => [
    questions,
    currentQuestionIndex,
    score,
    showResults
  ];
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}