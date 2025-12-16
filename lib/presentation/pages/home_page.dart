import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_advanced/presentation/pages/quiz_page.dart';
import 'package:flutter_quiz_advanced/presentation/pages/quiz_page_bloc.dart';
import 'package:flutter_quiz_advanced/presentation/pages/results_page.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../business_logic/blocs/quiz_bloc.dart';
import '../../business_logic/cubits/theme_cubit.dart';
import '../../data/models/quiz_result.dart';
import '../../data/providers/quiz_data_provider.dart';
import '../../data/repositories/quiz_repository.dart';
import '../animations/fade_animation.dart';
import '../animations/scale_animation.dart';
import '../animations/slide_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Flutter Avancé'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // Version avec Provider
              final themeCubit = context.read<ThemeCubit>();
              themeCubit.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showHistory,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withOpacity(0.05),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeAnimation(
                  duration: const Duration(milliseconds: 800),
                  child: ScaleAnimation(
                    duration: const Duration(milliseconds: 600),
                    child: const _WelcomeCard(),
                  ),
                ),
                const SizedBox(height: 40),
                SlideAnimation(
                  begin: const Offset(0, 1),
                  child: const _FeaturesSection(),
                ),
                const SizedBox(height: 40),
                FadeAnimation(
                  duration: const Duration(milliseconds: 1000),

                  child: const _QuizOptionsSection(),
                ),
                const SizedBox(height: 30),
                const _StatsSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Historique des Quiz',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Expanded(
                child: _HistoryList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Flutter Quiz Avancé',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.code,
                color: Theme.of(context).colorScheme.primary,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Provider & BLoC',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          children: [
            Icon(
              Icons.quiz,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Bienvenue sur\nFlutter Quiz Avancé',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Testez vos connaissances en Flutter avec deux approches de gestion d\'état',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Fonctionnalités',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: const [
            _FeatureCard(
              icon: Icons.architecture,
              title: 'Provider',
              description: 'Gestion d\'état simple et efficace',
              color: Colors.blue,
            ),
            _FeatureCard(
              icon: Icons.moving,
              title: 'BLoC Pattern',
              description: 'Architecture événementielle',
              color: Colors.green,
            ),
            _FeatureCard(
              icon: Icons.animation,
              title: 'Animations',
              description: 'Transitions fluides',
              color: Colors.purple,
            ),
            _FeatureCard(
              icon: Icons.palette,
              title: 'Thèmes',
              description: 'Mode clair/sombre',
              color: Colors.orange,
            ),
          ],
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizOptionsSection extends StatelessWidget {
  const _QuizOptionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Choisissez votre approche',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _QuizOptionCard(
                title: 'Provider',
                description: 'Approche simple avec ChangeNotifier',
                icon: Icons.toggle_on,
                color: Colors.blue,
                onTap: () => _navigateToProviderQuiz(context),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _QuizOptionCard(
                title: 'BLoC',
                description: 'Pattern événement/état avancé',
                icon: Icons.account_tree,
                color: Colors.green,
                onTap: () => _navigateToBlocQuiz(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => _showComparison(context),
          icon: const Icon(Icons.compare_arrows),
          label: const Text('Comparer les approches'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToProviderQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => QuizProvider(QuizRepositoryImpl()),
          child: const QuizPageProvider(),
        ),
      ),
    );
  }

  void _navigateToBlocQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => QuizBloc(QuizRepositoryImpl()),
          child: const QuizPageBloc(),
        ),
      ),
    );
  }

  void _showComparison(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Provider vs BLoC'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _ComparisonItem(
                title: 'Provider',
                advantages: [
                  'Plus simple à apprendre',
                  'Moins de code boilerplate',
                  'Idéal pour petites/moyennes applications',
                  'Intégré avec Flutter',
                ],
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const _ComparisonItem(
                title: 'BLoC',
                advantages: [
                  'Séparation claire des responsabilités',
                  'Meilleure testabilité',
                  'Évolutivité optimale',
                  'Gestion des événements complexes',
                ],
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              Text(
                'Recommandation:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• Choisissez Provider pour des applications simples\n'
                    '• Choisissez BLoC pour des applications complexes\n'
                    '• Les deux peuvent être utilisés ensemble',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Compris'),
          ),
        ],
      ),
    );
  }
}

class _ComparisonItem extends StatelessWidget {
  final String title;
  final List<String> advantages;
  final Color color;

  const _ComparisonItem({
    required this.title,
    required this.advantages,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  title[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...advantages.map((advantage) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: color,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    advantage,
                    style: TextStyle(
                      color: color.withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _QuizOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuizOptionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Commencer'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Statistiques',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  value: '5',
                  label: 'Questions',
                  icon: Icons.help_outline,
                  color: Colors.blue,
                ),
                _StatItem(
                  value: '100%',
                  label: 'Gratuit',
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
                _StatItem(
                  value: '2',
                  label: 'Approches',
                  icon: Icons.compare,
                  color: Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _HistoryList extends StatelessWidget {
  const _HistoryList();

  @override
  Widget build(BuildContext context) {
    // Données simulées pour l'historique
    final List<Map<String, dynamic>> historyData = [
      {
        'date': '2024-01-15',
        'score': '4/5',
        'approach': 'Provider',
        'time': '2:30',
      },
      {
        'date': '2024-01-14',
        'score': '3/5',
        'approach': 'BLoC',
        'time': '3:15',
      },
      {
        'date': '2024-01-13',
        'score': '5/5',
        'approach': 'Provider',
        'time': '2:45',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: historyData.length,
      itemBuilder: (context, index) {
        final item = historyData[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item['approach'] == 'Provider'
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item['approach'] == 'Provider'
                    ? Icons.toggle_on
                    : Icons.account_tree,
                color: item['approach'] == 'Provider'
                    ? Colors.blue
                    : Colors.green,
              ),
            ),
            title: Text('Score: ${item['score']}'),
            subtitle: Text('${item['date']} • ${item['time']} min'),
            trailing: Chip(
              label: Text(item['approach']),
              backgroundColor: item['approach'] == 'Provider'
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.green.withOpacity(0.2),
              labelStyle: TextStyle(
                color: item['approach'] == 'Provider'
                    ? Colors.blue
                    : Colors.green,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Exemple d'utilisation de la page de résultats
class ResultsPreviewPage extends StatelessWidget {
  const ResultsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Données simulées pour l'exemple
    final quizResult = QuizResult(
      score: 4,
      totalQuestions: 5,
      dateTime: DateTime.now(),
      duration: const Duration(minutes: 2, seconds: 30),
      questionResults: List.generate(5, (index) => QuestionResult(
        questionId: '$index',
        questionText: 'Question $index',
        selectedAnswer: 'Réponse $index',
        correctAnswer: 'Réponse $index',
        isCorrect: index != 2, // La question 2 est fausse
      )),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aperçu des résultats'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ResultsPage(quizResult: quizResult),
    );
  }
}