import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final List<Widget> children;
  const InfoCard({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: children,
      ),
    );
  }
}
