import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/body_text.dart';

class NoVisitorsFoundView extends StatelessWidget {
  const NoVisitorsFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyText.medium(
      'Aún no tienes visitantes registrados. Puedes agregar uno nuevo para generar una invitación.',
      color: Colors.grey.shade600,
      textAlign: TextAlign.center,
    );
  }
}