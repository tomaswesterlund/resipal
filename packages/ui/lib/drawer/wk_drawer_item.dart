import 'package:flutter/material.dart';

class WkDrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const WkDrawerItem({required this.icon, required this.label, required this.onTap, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final primaryColor = color ?? colorScheme.primary;
    final itemTextColor = color ?? colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: primaryColor, size: 24),
        ),
        title: Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: itemTextColor),
        ),
        tileColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }
}
