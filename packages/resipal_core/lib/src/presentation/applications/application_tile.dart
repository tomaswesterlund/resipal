import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/applications/application_role_icons.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class ApplicationTile extends StatelessWidget {
  final ApplicationEntity application;

  const ApplicationTile({required this.application, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color statusColor = application.status.color(colorScheme);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Go.to(ApplicationDetailsPage(application: application)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Asegura que todas las columnas inicien arriba
            children: [
              // 1. Icono de Estatus
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(Icons.document_scanner_outlined, size: 20, color: statusColor),
              ),
              const SizedBox(width: 16),

              // 2. Columna: Aplicante
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Aplicante'),
                    const SizedBox(height: 4), // Mismo spacing para todas
                    HeaderText.five(
                      application.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // 3. Columna: Roles (Ahora fuera del Row del nombre)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OverlineText('Roles'),
                  const SizedBox(height: 4),
                  ApplicationRoleIcons(application: application, size: 16),
                ],
              ),

              const SizedBox(width: 12),

              // 4. Columna: Estatus
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const OverlineText('Estatus'),
                    const SizedBox(height: 4),
                    StatusBadge(color: statusColor, label: application.status.display),
                  ],
                ),
              ),

              const SizedBox(width: 12),
              // Centramos el chevron verticalmente respecto al Row principal
              const Padding(
                padding: EdgeInsets.only(top: 12), // Ajuste manual para que el chevron se vea centrado
                child: Icon(Icons.chevron_right_rounded, size: 20, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
