import 'package:flutter/material.dart';
import 'package:ui/lib.dart';

class RolesView extends StatelessWidget {
  const RolesView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OverlineText('GUÍA DE PERMISOS'),
        const SizedBox(height: 8),
        HeaderText.three('Estructura de acceso'),
        const SizedBox(height: 12),
        BodyText.medium(
          'Cada rol determina qué acciones y secciones puede ver un usuario dentro de la plataforma.',
          color: colorScheme.outline,
        ),
        const SizedBox(height: 32),

        // Tarjetas de Roles
        _buildRoleExplanation(
          context,
          icon: Icons.admin_panel_settings_outlined,
          title: 'Administrador',
          subtitle: 'Control Total',
          description:
              'Gestión financiera completa, auditoría de pagos, edición de propiedades y aprobación de nuevos registros.',
          color: colorScheme.primary,
        ),

        _buildRoleExplanation(
          context,
          icon: Icons.home_work_outlined,
          title: 'Residente',
          subtitle: 'Usuario Final',
          description:
              'Consulta de estados de cuenta personales, descarga de comprobantes y participación en reportes vecinales.',
          color: colorScheme.outline,
        ),

        _buildRoleExplanation(
          context,
          icon: Icons.shield_outlined,
          title: 'Seguridad',
          subtitle: 'Monitoreo y Vigilancia',
          description:
              'Control de accesos peatonales y vehiculares, registro de visitas y reporte de incidencias en tiempo real.',
          color: colorScheme.secondary,
        ),
      ],
    );
  }

  Widget _buildRoleExplanation(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icono con diseño elevado sutil
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(width: 20),

          // Texto explicativo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    HeaderText.five(title, color: colorScheme.onSurface),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        subtitle.toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: colorScheme.onSurfaceVariant,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                BodyText.small(description, color: colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
