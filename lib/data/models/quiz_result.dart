import 'package:equatable/equatable.dart';

class QuizResult extends Equatable {
  final int score;
  final int totalQuestions;
  final DateTime dateTime;
  final Duration duration;
  final List<QuestionResult> questionResults;

  const QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.dateTime,
    required this.duration,
    required this.questionResults,
  });

  double get percentage => (score / totalQuestions) * 100;

  String get formattedDate {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String get formattedDuration {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  List<Object?> get props => [
    score,
    totalQuestions,
    dateTime,
    duration,
    questionResults,
  ];
}

class QuestionResult extends Equatable {
  final String questionId;
  final String questionText;
  final String selectedAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const QuestionResult({
    required this.questionId,
    required this.questionText,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [
    questionId,
    questionText,
    selectedAnswer,
    correctAnswer,
    isCorrect,
  ];
}