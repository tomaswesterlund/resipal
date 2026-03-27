import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/support/support_section.dart';

class OnboardingStartPage extends StatelessWidget {
  const OnboardingStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const MyAppBar(title: '¡Bienvenido a Resipal!', automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Welcome Section
            HeaderText.five(
              '¡Hola! Nos da gusto verte por aquí.',
              color: colorScheme.primary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Como usuario nuevo, queremos que explores todas las herramientas de administración sin compromiso.',
              style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // 2. Free Tier Callout
            _buildTierCard(
              context,
              title: 'Prueba Gratuita',
              properties: 'Hasta 10 propiedades',
              price: 'GRATIS',
              isHighlight: true,
              description:
                  'Ideal para conocer la plataforma y registrar tus primeras unidades. Disfruta de todas las herramientas sin presiones.',
              footerItems: [
                {'icon': Icons.credit_card_off_rounded, 'text': 'Sin tarjeta de crédito'},
                {'icon': Icons.sync_disabled_rounded, 'text': 'Sin suscripción forzosa'},
              ],
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: PrimaryButton(label: 'Comenzar ahora', onPressed: () => Go.to(OnboardingUserRegistrationPage())),
            ),
            const SizedBox(height: 16),

            // 3. Paid Tiers
            const Divider(height: 40),
            Text(
              'Planes de Crecimiento',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
            ),
            const SizedBox(height: 12),
            BodyText.small(
              'Nuestros planes son simples: solo \$500 MXN al mes por cada bloque de 100 propiedades.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            _buildTierCard(context, title: 'Plan 100', properties: 'Hasta 100 propiedades', price: '\$500 MXN / mes'),
            const SizedBox(height: 12),
            _buildTierCard(context, title: 'Plan 200', properties: 'Hasta 200 propiedades', price: '\$1,000 MXN / mes'),
            const SizedBox(height: 12),
            _buildTierCard(context, title: 'Plan 300', properties: 'Hasta 300 propiedades', price: '\$1,500 MXN / mes'),
            const SizedBox(height: 24),
            SupportSection(
              title: '¡Contáctanos si ya estás interesado en un plan o tienes dudas sobre cuál elegir!',
              onMessagePressed: () async {
                final whatsappService = WhatsAppService();
                await whatsappService.sendSupportMessage();
              },
              onEmailPressed: () {
                final emailService = EmailService();
                emailService.sendSupportEmail();
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTierCard(
    BuildContext context, {
    required String title,
    required String properties,
    required String price,
    String? description,
    List<Map<String, dynamic>>? footerItems,
    bool isHighlight = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isHighlight ? colorScheme.primary.withOpacity(0.05) : colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlight ? colorScheme.primary : colorScheme.outlineVariant,
          width: isHighlight ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              Text(
                price,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900, color: colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(properties, style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),

          if (description != null) ...[
            const SizedBox(height: 12),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.4),
            ),
          ],

          if (footerItems != null) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: footerItems
                  .map(
                    (item) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(item['icon'] as IconData, size: 16, color: colorScheme.primary),
                        const SizedBox(width: 6),
                        Text(
                          item['text'] as String,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
