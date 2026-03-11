import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';

class RolesLegend extends StatelessWidget {
  const RolesLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OverlineText('DEFINICIÓN DE ROLES'),
        const SizedBox(height: 16),
        _buildRoleRow(
          context,
          icon: Icons.admin_panel_settings,
          name: 'ADMINISTRADOR',
          description: 'Acceso total a finanzas, gestión de propiedades y aprobación de solicitudes.',
          iconColor: colorScheme.primary,
        ),
        const SizedBox(height: 12),
        _buildRoleRow(
          context,
          icon: Icons.shield_outlined,
          name: 'SEGURIDAD',
          description: 'Control de accesos, registro de visitas y monitoreo de incidencias en tiempo real.',
          iconColor: colorScheme.secondary,
        ),
        const SizedBox(height: 12),
        _buildRoleRow(
          context,
          icon: Icons.home_work_outlined,
          name: 'RESIDENTE',
          description: 'Consulta de estados de cuenta, reserva de áreas comunes y reportes vecinales.',
          iconColor: colorScheme.outline,
        ),
      ],
    );
  }

  Widget _buildRoleRow(
    BuildContext context, {
    required IconData icon,
    required String name,
    required String description,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText.small(
                name,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 2),
              BodyText.tiny(
                description,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ],
    );
  }
}