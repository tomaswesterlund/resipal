import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/invitations/invitation_details_page.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';
import 'package:intl/intl.dart';

class InvitationTile extends StatelessWidget {
  final InvitationEntity invitation;

  const InvitationTile({required this.invitation, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final String dateRange =
        "${DateFormat('dd/MM').format(invitation.fromDate)} - ${DateFormat('dd/MM').format(invitation.toDate)}";

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Go.to(InvitationDetailsPage(invitation: invitation)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            children: [
              // 1. Icono con Estatus Visual
              _buildStatusIcon(colorScheme),
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

              // 3. Info de Uso y Vigencia
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusBadge(
                      label: invitation.canEnter ? 'VÁLIDA' : 'EXPIRADA',
                      color: invitation.canEnter ? Colors.green : colorScheme.error,
                    ),
                    const SizedBox(height: 4),
                    BodyText.small(
                      'Uso: ${invitation.usageCount}/${invitation.maxEntries}',
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded, size: 20, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(ColorScheme colorScheme) {
    final bool canEnter = invitation.canEnter;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (canEnter ? colorScheme.primary : colorScheme.error).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        canEnter ? Icons.confirmation_number_outlined : Icons.block_outlined,
        size: 20,
        color: canEnter ? colorScheme.primary : colorScheme.error,
      ),
    );
  }
}
