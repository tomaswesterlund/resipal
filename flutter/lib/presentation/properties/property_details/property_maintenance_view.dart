import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/presentation/maintenance/maintenance_fee_card.dart';

class PropertyMaintenanceView extends StatelessWidget {
  final PropertyEntity property;
  const PropertyMaintenanceView(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    if (property.contract == null) {
      return Center(child: BodyText.medium('Ningún contrato asignado a esta propiedad.'));
    }

    if (property.fees.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: BodyText.medium(
          'No se encontraron cobros de mantenimiento para esta propiedad.',
          color: Colors.grey.shade600,
          textAlign: TextAlign.center,
        ),
      );
    }

    property.fees.sort((a, b) => b.dueDate.compareTo(a.dueDate));

    return ListView.builder(
      itemCount: property.fees.length,
      itemBuilder: (context, index) {
        final fee = property.fees[index];
        return MaintenanceFeeCard(fee);
      },
    );
  }
}
