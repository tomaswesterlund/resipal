import 'package:flutter/material.dart';

class SectionHeaderText extends StatelessWidget {
  final String text;
  const SectionHeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1),
    );
  }
}