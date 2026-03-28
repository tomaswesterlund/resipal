import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';
import 'package:ui/support/support_section.dart';

class PropertyLimitReachedView extends StatelessWidget {
  const PropertyLimitReachedView({super.key});

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
              decoration: BoxDecoration(color: colorScheme.error.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.home_work_outlined, size: 64, color: colorScheme.error),
            ),
            const SizedBox(height: 32),
            HeaderText.four(
              'Límite de propiedades alcanzado',
              textAlign: TextAlign.center,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Has alcanzado el número máximo de propiedades disponibles en tu plan actual. Contacta a Resipal para actualizar tu membresía y registrar más propiedades.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.5),
            ),
            const SizedBox(height: 48),
            SupportSection(
              title: '¿Necesitas más propiedades? Contáctanos para actualizar tu plan.',
              onMessagePressed: () async {
                final whatsappService = WhatsAppService();
                await whatsappService.sendSupportMessage();
              },
              onEmailPressed: () {
                final emailService = EmailService();
                emailService.sendSupportEmail();
              },
            ),
          ],
        ),
      ),
    );
  }
}
