import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/enums/invitation_status.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class InvitationTile extends StatelessWidget {
  final InvitationEntity invitation;

  const InvitationTile({required this.invitation, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final status = invitation.status;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Go.to(InvitationDetailsPage(invitation: invitation)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            children: [
              // 1. Icono dinámico según el Enum
              _buildStatusIcon(colorScheme, status),
              const SizedBox(width: 16),

              // 2. Info del Visitante y Propiedad
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OverlineText(invitation.property.name),
                    HeaderText.five(invitation.visitor.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),

              // 3. StatusBadge y Contador de Uso
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusBadge(label: status.display.toUpperCase(), color: status.color(colorScheme)),
                    const SizedBox(height: 4),
                    BodyText.small(
                      invitation.maxEntries == null
                          ? 'Ilimitada'
                          : 'Uso: ${invitation.usageCount} / ${invitation.maxEntries}',
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, size: 20, color: colorScheme.onSurface.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(ColorScheme colorScheme, InvitationStatus status) {
    final statusColor = status.color(colorScheme);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: statusColor.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(status.icon, size: 20, color: statusColor),
    );
  }
}
