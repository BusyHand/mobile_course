// lib/widgets/calc_button.dart
import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const CalcButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 24)),
    );
  }
}
