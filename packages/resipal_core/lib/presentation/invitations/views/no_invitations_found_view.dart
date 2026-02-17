import 'package:flutter/material.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';

class NoInvitationsFoundView extends StatelessWidget {
  const NoInvitationsFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyText.medium(
      'No se encontraron invitaciones vinculadas a tu cuenta.',
      color: Colors.grey.shade600,
      textAlign: TextAlign.center,
    );
  }
}
