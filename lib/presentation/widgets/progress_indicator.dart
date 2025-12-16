import 'package:flutter/material.dart';

class QuizProgressIndicator extends StatelessWidget {
  final int current;
  final int total;
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  const QuizProgressIndicator({
    super.key,
    required this.current,
    required this.total,
    required this.progress,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question $current/$total',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: inactiveColor.withOpacity(0.3),
          color: activeColor,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}