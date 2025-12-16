class Question {
  final String id;
  final String text;
  final String? imageUrl;
  final List<String> answers;
  final int correctAnswerIndex;

  Question({
    required this.id,
    required this.text,
    this.imageUrl,
    required this.answers,
    required this.correctAnswerIndex,
  });
}