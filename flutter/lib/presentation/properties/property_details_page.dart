import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/cards/hero_card.dart';
import 'package:resipal/core/ui/cards/info_container.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/info_tile.dart';
import 'package:resipal/domain/entities/property_entity.dart';

class PropertyDetailsPage extends StatelessWidget {
  final PropertyEntity property;
  const PropertyDetailsPage(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(property.name),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              /* Edit logic */
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroCard(title: property.name, description: property.description),
            const SizedBox(height: 25),

            // Information Section
            const SectionHeaderText(text: 'DETALLES TÉCNICOS'),
            InfoCard(
              children: [
                InfoTile(
                  icon: Icons.fingerprint,
                  label: 'ID de Propiedad',
                  text: property.id.split('-').first.toUpperCase(),
                ),
                const Divider(height: 1),
                InfoTile(
                  icon: Icons.calendar_today_outlined,
                  label: 'Fecha de Registro',
                  text: property.createdAt.toShortDate(),
                ),
                const Divider(height: 1),
                InfoTile(
                  icon: Icons.person_outline,
                  label: 'Propietario',
                  text: property.user.name,
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Information Section
            const SectionHeaderText(text: 'CONTRATO'),
            InfoCard(
              children: [
                InfoTile(
                  icon: Icons.control_camera_outlined,
                  label: 'Nombre',
                  text: property.contract.name,
                ),
                const Divider(height: 1),
                InfoTile(
                  icon: Icons.calendar_today_outlined,
                  label: 'Periodo',
                  text: property.contract.period
                ),
                const Divider(height: 1),
                InfoTile(
                  icon: Icons.person_outline,
                  label: 'Costo (por periodo)',
                  text: CurrencyFormatter.fromCents(property.contract.amountInCents)
                ),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
