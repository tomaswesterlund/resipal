import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';

class InvitationInformationView extends StatelessWidget {
  final InvitationEntity invitation;
  const InvitationInformationView(this.invitation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeaderText(text: 'INFORMACIÓN GENERAL'),
        DefaultCard(
          padding: 0,
          child: Column(
            children: [
              DetailTile(icon: Icons.home_work_outlined, label: 'Propiedad', value: invitation.property.name),
              const Divider(height: 1),
              DetailTile(
                icon: Icons.calendar_today_outlined,
                label: 'Válido',
                value: DateFormatters.toDateRange(invitation.fromDate, invitation.toDate),
              ),

              const Divider(height: 1),
              DetailTile(
                icon: Icons.pin_outlined,
                label: 'Uso de Entradas',
                value: '${invitation.usageCount} / ${invitation.maxEntries} (${invitation.remainingEntries} restantes)',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
