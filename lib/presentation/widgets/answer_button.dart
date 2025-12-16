import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool showCorrect;
  final bool isCorrect;

  const AnswerButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.showCorrect = false,
    this.isCorrect = false,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.blue.shade50;
    Color textColor = Colors.blue.shade900;
    Color borderColor = Colors.transparent;

    if (widget.isSelected) {
      if (widget.showCorrect) {
        if (widget.isCorrect) {
          backgroundColor = Colors.green.shade100;
          textColor = Colors.green.shade900;
          borderColor = Colors.green;
        } else {
          backgroundColor = Colors.red.shade100;
          textColor = Colors.red.shade900;
          borderColor = Colors.red;
        }
      } else {
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade900;
        borderColor = Colors.blue;
      }
    } else if (widget.showCorrect && widget.isCorrect) {
      backgroundColor = Colors.green.shade100;
      textColor = Colors.green.shade900;
      borderColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (widget.showCorrect && widget.isCorrect)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  ),
                if (widget.isSelected && !widget.isCorrect && widget.showCorrect)
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}