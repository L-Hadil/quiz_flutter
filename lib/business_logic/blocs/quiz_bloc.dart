import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/quiz_repository.dart';
import '../../data/models/question.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _repository;

  QuizBloc(this._repository) : super(QuizInitial()) {
    on<LoadQuestionsEvent>(_onLoadQuestions);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<ResetQuizEvent>(_onResetQuiz);

    add(LoadQuestionsEvent());
  }

  Future<void> _onLoadQuestions(
      LoadQuestionsEvent event,
      Emitter<QuizState> emit,
      ) async {
    emit(QuizLoading());

    try {
      final questions = await _repository.fetchQuestions();
      emit(QuizLoaded(questions: questions));
    } catch (e) {
      emit(QuizError('Erreur de chargement: ${e.toString()}'));
    }
  }

  void _onAnswerQuestion(
      AnswerQuestionEvent event,
      Emitter<QuizState> emit,
      ) {
    if (state is! QuizLoaded) return;

    final currentState = state as QuizLoaded;
    final questions = currentState.questions;
    int newScore = currentState.score;
    int newIndex = currentState.currentQuestionIndex;
    bool showResults = false;

    if (event.answerIndex == currentState.currentQuestion.correctAnswerIndex) {
      newScore++;
    }

    if (newIndex < questions.length - 1) {
      newIndex++;
    } else {
      showResults = true;
    }

    emit(
      currentState.copyWith(
        currentQuestionIndex: newIndex,
        score: newScore,
        showResults: showResults,
      ),
    );
  }

  void _onResetQuiz(
      ResetQuizEvent event,
      Emitter<QuizState> emit,
      ) {
    if (state is! QuizLoaded) return;

    final currentState = state as QuizLoaded;
    emit(
      currentState.copyWith(
        currentQuestionIndex: 0,
        score: 0,
        showResults: false,
      ),
    );
  }
}

extension QuizLoadedExtension on QuizLoaded {
  QuizLoaded copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    int? score,
    bool? showResults,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      showResults: showResults ?? this.showResults,
    );
  }
}