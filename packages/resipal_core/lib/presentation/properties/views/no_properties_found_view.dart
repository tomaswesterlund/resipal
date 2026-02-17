import 'package:flutter/material.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';

class NoPropertiesFoundView extends StatelessWidget {
  const NoPropertiesFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyText.medium(
      'No se encontraron propiedades vinculadas a tu cuenta. Contacta al administrador para registrar una.',
      color: Colors.grey.shade600,
      textAlign: TextAlign.center,
    );
  }
}
