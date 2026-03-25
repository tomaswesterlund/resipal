import 'package:flutter/material.dart';

class BadgeIndicator extends StatelessWidget {
  final Color color;
  final String text;
  final Color borderColor;
  final Color textColor;

  const BadgeIndicator({
    super.key,
    required this.color,
    required this.text,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(color: borderColor, shape: BoxShape.circle),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
