import 'package:flutter/material.dart';

class OverlineText extends StatelessWidget {
  final String text;
  final Color? color;

  const OverlineText(this.text, {this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.5,
        color: color ?? theme.hintColor,
      ),
    );
  }
}
