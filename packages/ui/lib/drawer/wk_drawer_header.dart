import 'package:flutter/material.dart';
import 'package:ui/texts/header_text.dart';

class WkDrawerHeader extends StatelessWidget {
  final String name;
  final String email;

  const WkDrawerHeader({required this.name, required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 24, bottom: 32, right: 24),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: colorScheme.onPrimary.withOpacity(0.2),
            child: Icon(Icons.business, color: colorScheme.onPrimary, size: 35),
          ),
          const SizedBox(height: 16),
          HeaderText.five(name, color: colorScheme.onPrimary),
          const SizedBox(height: 4),
          Text(
            email,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
