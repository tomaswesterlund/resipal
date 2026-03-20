import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

class EmptyPropertiesView extends StatelessWidget {
  final bool showRegisterProperty;
  const EmptyPropertiesView({required this.showRegisterProperty, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.home_work_outlined, size: 64, color: colorScheme.primary),
            ),
            const SizedBox(height: 32),
            HeaderText.four('Sin propiedades', textAlign: TextAlign.center, color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Aún no se ha dado de alta ninguna propiedad.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.inverseSurface),
            ),

            const SizedBox(height: 32),
            if (showRegisterProperty)
              TextButton.icon(
                onPressed: () => Go.to(const RegisterPropertyPage()),
                icon: const Icon(Icons.add),
                label: const Text('Registrar propiedad'),
                style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
              ),
          ],
        ),
      ),
    );
  }
}
