import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/cards/hero_card.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/property_entity.dart';

class PropertyDetailsPage extends StatelessWidget {
  final PropertyEntity property;
  const PropertyDetailsPage(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MyAppBar(title: 'Detalle de Propiedad'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroCard(property),
            const SizedBox(height: 24),

            SectionHeaderText(text: 'INFORMACIÓN GENERAL'),
            DefaultCard(
              padding: 0,
              child: Column(
                children: [
                  DetailTile(
                    icon: Icons.fingerprint,
                    label: 'ID de Propiedad',
                    value: property.id.split('-').first.toUpperCase(),
                  ),
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
                    value: property.user.name,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SectionHeaderText(text: 'CONTRATO'),
            DefaultCard(
              padding: 0,
              child: Column(
                children: [
                  DetailTile(
                    icon: Icons.control_camera_outlined,
                    label: 'Nombre',
                    value: property.contract.name,
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.calendar_today_outlined,
                    label: 'Periodo',
                    value: property.contract.period,
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.person_outline,
                    label: 'Costo (por periodo)',
                    value: CurrencyFormatter.fromCents(
                      property.contract.amountInCents,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
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
