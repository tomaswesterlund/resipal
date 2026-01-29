import 'package:flutter/material.dart';
import 'package:resipal/core/ui/views/empty_state_view.dart';

class NoPropertiesFoundView extends StatelessWidget {
  const NoPropertiesFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      icon: Icons.domain_disabled_rounded,
      title: 'No hay propiedades',
      message: 'No se encontraron propiedades vinculadas a tu cuenta. Contacta al administrador para registrar una.',
    );
  }
}