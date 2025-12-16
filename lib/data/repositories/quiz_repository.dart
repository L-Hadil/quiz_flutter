import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class QuizRepository {
  Future<List<Question>> fetchQuestions();
  Future<List<Question>> fetchQuestionsByCategory(String category);
  Stream<List<Question>> getQuestionsStream();
}

class QuizRepositoryImpl implements QuizRepository {
  final List<Question> _questions = [
    Question(
      id: '1',
      text: 'Quel est le langage de programmation utilisé par Flutter?',
      imageUrl: 'https://mobizel.com/wp-content/uploads/2019/09/article_flutter_mobizel@2x-1200x520.png',
      answers: ['Java', 'Dart', 'Kotlin', 'Swift'],
      correctAnswerIndex: 1,
    ),
    Question(
      id: '2',
      text: 'Quel widget utilise-t-on pour créer une liste déroulante?',
      imageUrl: 'https://graphiste.com/blog/wp-content/uploads/sites/4/2023/01/Image-a-la-une-liste-deroulante-740x447.png',
      answers: ['ListView', 'Column', 'Row', 'Stack'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '3',
      text: 'Quelle méthode utilise-t-on pour naviguer vers une nouvelle page?',
      imageUrl: 'https://ptyagicodecamp.github.io/unnamed-navigation.jpg',
      answers: [
        'Navigator.push()',
        'Navigator.pop()',
        'Navigator.replace()',
        'Navigator.jump()'
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '4',
      text: 'Quel est le widget racine d\'une application Flutter?',
      imageUrl: 'https://media.licdn.com/dms/image/v2/D4E12AQEjMwPqwlVXwA/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1690810968333?e=1767225600&v=beta&t=g5K-sSMR4DJIsuXv49PR79Pd2Zji0-Uav5CeOGco0-w',
      answers: ['MaterialApp', 'Scaffold', 'Container', 'WidgetsApp'],
      correctAnswerIndex: 0,
    ),
    Question(
      id: '5',
      text: 'Quelle commande utilise-t-on pour créer un nouveau projet Flutter?',
      imageUrl: 'https://user-images.githubusercontent.com/5479/32118458-a62b414c-bb06-11e7-9b1c-66a389ef4910.png',
      answers: [
        'flutter create',
        'flutter new',
        'flutter init',
        'flutter start'
      ],
      correctAnswerIndex: 0,
    ),
  ];

  @override
  Future<List<Question>> fetchQuestions() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _questions;
  }

  @override
  Future<List<Question>> fetchQuestionsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _questions
        .where((q) => q.text.toLowerCase().contains(category.toLowerCase()))
        .toList();
  }

  @override
  Stream<List<Question>> getQuestionsStream() async* {
    for (int i = 0; i < _questions.length; i += 2) {
      await Future.delayed(const Duration(milliseconds: 300));
      yield _questions.sublist(0, i + 1);
    }
    yield _questions;
  }

  Future<List<Question>> loadQuestionsFromAssets() async {
    try {
      return _questions;
    } catch (e) {
      debugPrint('Erreur de chargement: $e');
      return [];
    }
  }
}
