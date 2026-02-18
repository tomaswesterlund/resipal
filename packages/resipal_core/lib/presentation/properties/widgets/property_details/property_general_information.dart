import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/helpers/formatters/date_formatters.dart';
import 'package:resipal_core/helpers/formatters/id_formatter.dart';
import 'package:resipal_core/presentation/shared/cards/default_card.dart';
import 'package:resipal_core/presentation/shared/cards/green_box_card.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/texts/section_header_text.dart';
import 'package:resipal_core/presentation/shared/tiles/detail_tile.dart';

class PropertyGeneralInformation extends StatelessWidget {
  final PropertyEntity property;
  const PropertyGeneralInformation(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // _buildHeroCard(property),
          GreenBoxCard(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(Icons.house, size: 96, color: Colors.white),
                  HeaderText.two(property.name, color: Colors.white),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          SectionHeaderText(text: 'INFORMACIÓN GENERAL'),
          DefaultCard(
            padding: 0,
            child: Column(
              children: [
                DetailTile(icon: Icons.fingerprint, label: 'ID de Propiedad', value: property.id.toShortId()),
                const Divider(height: 1),
                DetailTile(icon: Icons.person_outline, label: 'Propietario', value: property.resident?.name ?? 'No hay propietario asociado.'),

                const Divider(height: 1),
                DetailTile(icon: Icons.calendar_today_outlined, label: 'Fecha de registro (en Resipal)', value: property.createdAt.toShortDate()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
