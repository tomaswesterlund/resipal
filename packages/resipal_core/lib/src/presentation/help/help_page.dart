import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Para el icono de WhatsApp
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';
import 'package:wester_kit/ui/my_app_bar.dart';
import 'package:wester_kit/ui/texts/header_text.dart';
import 'package:wester_kit/ui/texts/body_text.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const MyAppBar(title: 'Soporte y Ayuda'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Icono o Logo de ayuda
            Icon(Icons.help_outline_rounded, size: 80, color: colorScheme.primary),
            const SizedBox(height: 24),

            // Título principal
            HeaderText.three('¿Cómo podemos ayudarte?', color: colorScheme.inverseSurface),
            const SizedBox(height: 16),

            // Breve introducción
            Text(
              'Si tienes problemas con tu membresía, el acceso a tu comunidad o dudas sobre el funcionamiento de Resipal, nuestro equipo está listo para apoyarte.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant, height: 1.5),
            ),
            const SizedBox(height: 40),

            // Sección de WhatsApp (Primary Action)
            WhatsAppContactButton(
              phoneNumber: Constants.supportPhoneNumber,
              label: 'Chat de Soporte',
              message: 'Hola equipo de Resipal, necesito ayuda con lo siguiente:',
            ),
            const SizedBox(height: 12),
            BodyText.small('Respuesta rápida vía chat'),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),

            // Sección de Email (Secondary Action)
            EmailContactButton(
              email: Constants.supportEmail,
              label: 'Enviar un correo',
              subject: 'Solicitud de Soporte - Usuario Resipal',
              body: 'Describe tu problema aquí...',
            ),
            const SizedBox(height: 12),
            BodyText.small('Para consultas detalladas'),
          ],
        ),
      ),
    );
  }
}
