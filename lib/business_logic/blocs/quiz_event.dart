abstract class QuizEvent {}

class LoadQuestionsEvent extends QuizEvent {}

class AnswerQuestionEvent extends QuizEvent {
  final int answerIndex;

  AnswerQuestionEvent(this.answerIndex);
}

class ResetQuizEvent extends QuizEvent {}