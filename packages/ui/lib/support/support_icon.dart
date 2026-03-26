import 'package:flutter/material.dart';

class SupportIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SupportIcon({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Icon(icon, color: colorScheme.primary, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: colorScheme.primary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
