import 'package:flutter/material.dart';
import 'package:ui/support/support_icon.dart';

class SupportSection extends StatelessWidget {
  final String title;
  final VoidCallback onMessagePressed;
  final VoidCallback onEmailPressed;

  const SupportSection({
    this.title = '¿Necesitas ayuda con el acceso?',
    required this.onMessagePressed,
    required this.onEmailPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Text(
          title,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.outline.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SupportIcon(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'WhatsApp',
              onTap: onMessagePressed, // Passed directly
            ),
            const SizedBox(width: 56),
            SupportIcon(
              icon: Icons.email_outlined,
              label: 'Correo',
              onTap: onEmailPressed, // Passed directly
            ),
          ],
        ),
      ],
    );
  }
}
