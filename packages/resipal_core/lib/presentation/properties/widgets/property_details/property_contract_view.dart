import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/helpers/formatters/currency_formatter.dart';
import 'package:resipal_core/presentation/shared/cards/default_card.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';
import 'package:resipal_core/presentation/shared/texts/section_header_text.dart';
import 'package:resipal_core/presentation/shared/tiles/detail_tile.dart';

class PropertyContractView extends StatelessWidget {
  final PropertyEntity property;
  const PropertyContractView(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    if (property.contract == null) {
      return Center(child: BodyText.medium('Ningún contrato asignado a esta propiedad.'));
    }

    final contract = property.contract!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SectionHeaderText(text: 'CONTRATO'),
          DefaultCard(
            padding: 0,
            child: Column(
              children: [
                DetailTile(icon: Icons.control_camera_outlined, label: 'Nombre', value: contract.name),
                const Divider(height: 1),
                DetailTile(icon: Icons.calendar_today_outlined, label: 'Periodo', value: contract.period),
                const Divider(height: 1),
                DetailTile(icon: Icons.person_outline, label: 'Costo (por periodo)', value: CurrencyFormatter.fromCents(contract.amountInCents)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
