import 'package:flutter/material.dart';
import 'package:resipal/core/ui/views/empty_state_view.dart';

class NoInvitationsFoundView extends StatelessWidget {
  const NoInvitationsFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      icon: Icons.domain_disabled_rounded,
      title: 'No hay invitaciones',
      message: 'No se encontraron invitaciones vinculadas a tu cuenta.',
    );
  }
}