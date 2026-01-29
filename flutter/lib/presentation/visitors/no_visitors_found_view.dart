import 'package:flutter/material.dart';
import 'package:resipal/core/ui/views/empty_state_view.dart';

class NoVisitorsFoundView extends StatelessWidget {
  const NoVisitorsFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      icon: Icons.people_outline_rounded,
      title: 'Lista de visitantes vacía',
      message: 'Aún no tienes visitantes registrados. Puedes agregar uno nuevo para generar una invitación.',
    );
  }
}