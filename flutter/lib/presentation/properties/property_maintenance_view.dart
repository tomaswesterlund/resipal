import 'package:flutter/material.dart';
import 'package:resipal/domain/entities/user_property_entity.dart';
import 'package:resipal/presentation/maintenance/maintenance_fee_card.dart';
import 'package:resipal/presentation/properties/maintenance_fee_tile.dart';

class PropertyMaintenanceView extends StatelessWidget {
  final UserPropertyEntity property;
  const PropertyMaintenanceView(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: property.contract.fees.length,
      itemBuilder: (context, index) {
        final fee = property.contract.fees[index];
        return MaintenanceFeeTile(fee);
      },
    );
  }
}
