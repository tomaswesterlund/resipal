import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final Color color;
  final String label;
  const StatusBadge({required this.color, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.bold, letterSpacing: 0.5, fontSize: 9),
      ),
    );
  }
}