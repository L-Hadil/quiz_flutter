class AppConstants {
  static const String appName = 'Flutter Quiz Avancé';
  static const String appVersion = '1.0.0';

  // Durées d'animation
  static const Duration fastAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // Routes
  static const String homeRoute = '/';
  static const String quizRoute = '/quiz';
  static const String resultsRoute = '/results';
  static const String settingsRoute = '/settings';

  // Storage keys
  static const String highScoreKey = 'high_score';
  static const String themeModeKey = 'theme_mode';
  static const String quizHistoryKey = 'quiz_history';

  // API (si nécessaire)
  static const String apiBaseUrl = 'https://api.example.com';
  static const String questionsEndpoint = '/questions';
}

class QuizCategories {
  static const String flutter = 'Flutter';
  static const String dart = 'Dart';
  static const String mobile = 'Mobile';
  static const String programming = 'Programming';

  static const List<String> all = [flutter, dart, mobile, programming];
}