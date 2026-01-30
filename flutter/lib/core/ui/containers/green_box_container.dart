import 'package:flutter/material.dart';

class GreenBoxContainer extends StatelessWidget {
  final Widget child;
  const GreenBoxContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      width: double.infinity,
      decoration: BoxDecoration(
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
