import 'package:flutter/material.dart';
import 'package:ui/texts/header_text.dart';

class InputLabel extends StatelessWidget {
  final String label;
  final String? description; // Optional detailed body text
  final String? helpText; // Optional info icon text
  final bool isRequired;

  const InputLabel({required this.label, this.description, this.helpText, this.isRequired = false, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row for Label + Required Indicator + Help Icon
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderText.six(label, color: colorScheme.primary),
            if (isRequired)
              Text(
                ' *',
                style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.error, fontWeight: FontWeight.bold),
              ),
            if (helpText != null) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _showHelpDialog(context, theme),
                child: Icon(Icons.help_outline_rounded, size: 18, color: colorScheme.outline),
              ),
            ],
          ],
        ),

        // Optional Description (The "Body" text below the header)
        if (description != null) ...[
          const SizedBox(height: 6.0),
          Text(
            description!,
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.4),
          ),
        ],
      ],
    );
  }

  void _showHelpDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(label, style: theme.textTheme.titleLarge),
        content: Text(helpText!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Entendido'))],
      ),
    );
  }
}
