import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/formatters/id_formatter.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/user_property_entity.dart';

class PropertyGeneralInformation extends StatelessWidget {
  final PropertyEntity property;
  const PropertyGeneralInformation(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildHeroCard(property),
          const SizedBox(height: 24),

          SectionHeaderText(text: 'INFORMACIÓN GENERAL'),
          DefaultCard(
            padding: 0,
            child: Column(
              children: [
                DetailTile(icon: Icons.fingerprint, label: 'ID de Propiedad', value: property.id.toShortId()),
                const Divider(height: 1),
                DetailTile(
                  icon: Icons.calendar_today_outlined,
                  label: 'Fecha de registro (en Resipal)',
                  value: property.createdAt.toShortDate(),
                ),
                const Divider(height: 1),
                DetailTile(
                  icon: Icons.person_outline,
                  label: 'Propietario',
                  value: property.owner?.name ?? 'No hay propietario asociado.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(PropertyEntity property) {
    return DefaultCard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(child: HeaderText.two(property.name)),
            const SizedBox(height: 8),
            BodyText.medium(property.description ?? ''),
          ],
        ),
      ),
    );
  }
}
