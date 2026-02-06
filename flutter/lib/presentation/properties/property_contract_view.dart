import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/user_property_entity.dart';

class PropertyContractView extends StatelessWidget {
  final UserPropertyEntity property;
  const PropertyContractView(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SectionHeaderText(text: 'CONTRATO'),
          DefaultCard(
            padding: 0,
            child: Column(
              children: [
                DetailTile(icon: Icons.control_camera_outlined, label: 'Nombre', value: property.contract.name),
                const Divider(height: 1),
                DetailTile(icon: Icons.calendar_today_outlined, label: 'Periodo', value: property.contract.period),
                const Divider(height: 1),
                DetailTile(
                  icon: Icons.person_outline,
                  label: 'Costo (por periodo)',
                  value: CurrencyFormatter.fromCents(property.contract.amountInCents),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
