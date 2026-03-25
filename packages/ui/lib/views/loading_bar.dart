import 'package:flutter/material.dart';
import 'package:ui/texts/body_text.dart';
import 'package:ui/texts/header_text.dart';

class LoadingBar extends StatelessWidget {
  final String title;
  final String? description;
  final Color? color;

  const LoadingBar({
    this.title = 'Cargando información...', 
    this.description, 
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Resolve the progress bar color: 
    // Priority (Constructor -> Secondary -> Primary)
    final indicatorColor = color ?? colorScheme.secondary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: LinearProgressIndicator(
              backgroundColor: colorScheme.outlineVariant.withOpacity(0.2),
              color: indicatorColor,
              minHeight: 2,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(height: 24),
          HeaderText.four(
            title, 
            textAlign: TextAlign.center, 
            color: colorScheme.onSurface,
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            BodyText.small(
              description!, 
              textAlign: TextAlign.center, 
              color: colorScheme.outline,
            ),
          ],
        ],
      ),
    );
  }
}