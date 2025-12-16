import 'package:flutter/material.dart';
import '../../data/models/question.dart';
import '../../data/repositories/quiz_repository.dart';
import '../repositories/ScoreRepository.dart';
class QuizProvider extends ChangeNotifier {
  final QuizRepository _repository;
  final ScoreRepository _scoreRepository = ScoreRepository();

  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = true;

  QuizProvider(this._repository) {
    _loadQuestions();
  }

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isLoading => _isLoading;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  int get totalQuestions => _questions.length;


  double get progress {
    if (totalQuestions == 0) return 0.0;
    return ((_currentQuestionIndex + 1) / totalQuestions).clamp(0.0, 1.0);
  }

  Future<void> _loadQuestions() async {
    _isLoading = true;
    notifyListeners();

    _questions = await _repository.fetchQuestions();
    _isLoading = false;
    notifyListeners();
  }

  void answerQuestion(int answerIndex) {
    if (answerIndex == currentQuestion.correctAnswerIndex) {
      _score++;
    }

    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
    } else {
      // dernière question -> sauvegarde score
      _saveHighScore();
    }

    notifyListeners();
  }

  Future<void> _saveHighScore() async {
    await _scoreRepository.saveHighScore(_score);
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    notifyListeners();
  }
}
