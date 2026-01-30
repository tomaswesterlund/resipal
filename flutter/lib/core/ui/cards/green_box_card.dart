import 'package:flutter/material.dart';

class GreenBoxCard extends StatelessWidget {
  final Widget child;
  const GreenBoxCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF002B2A), Color(0xFF1A4644)],
        ),
      ),
      child: child,
    );
  }
}
