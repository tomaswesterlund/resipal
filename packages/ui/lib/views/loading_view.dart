import 'package:flutter/material.dart';
import 'package:ui/texts/body_text.dart';
import 'package:ui/texts/header_text.dart';

class LoadingView extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? logo;

  const LoadingView({this.title = 'Cargando información...', this.description, this.logo, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible logo section
            if (logo != null) ...[Opacity(opacity: 0.8, child: logo!), const SizedBox(height: 40)],

            // A sleek, thin progress bar using theme colors
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                backgroundColor: colorScheme.surfaceVariant,
                color: colorScheme.secondary,
                minHeight: 2,
              ),
            ),
            const SizedBox(height: 24),

            // Title using H3 style (20px / 28 line)
            HeaderText.three(title, textAlign: TextAlign.center),

            // Description using Body Medium (16px / 24 line)
            if (description != null) ...[
              const SizedBox(height: 8),
              BodyText.medium(description!, textAlign: TextAlign.center, color: theme.hintColor),
            ],
          ],
        ),
      ),
    );
  }
}
