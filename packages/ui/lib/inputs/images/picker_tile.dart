import 'package:flutter/material.dart';

class PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const PickerTile({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            // Uses the same outline color as standard InputDecorations
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: colorScheme.primary, size: 30),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600, color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
