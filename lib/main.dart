import 'package:flutter/material.dart';
import 'package:flutter_quiz_advanced/presentation/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubits/theme_cubit.dart';
import 'presentation/pages/quiz_page.dart';
import 'presentation/pages/quiz_page_bloc.dart';
import 'data/providers/quiz_data_provider.dart';
import 'data/repositories/quiz_repository.dart';
import 'business_logic/blocs/quiz_bloc.dart';

void main() {
  runApp(const MyApp());
}
// Dans votre main.dart, remplacez :
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Avancé',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (_) => ThemeCubit(),
        child: const HomePage(), // Utilisez SimpleHomePage pour la version simple
      ),
    );
  }
}