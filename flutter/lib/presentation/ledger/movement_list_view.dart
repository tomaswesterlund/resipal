import 'package:flutter/material.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/enums/movement_type.dart';
import 'package:resipal/presentation/ledger/tiles/maintenance_fee_tile.dart';
import 'package:resipal/presentation/ledger/tiles/movement_tile.dart';
import 'package:resipal/presentation/ledger/tiles/payment_movement_tile.dart';

class MovementListView extends StatelessWidget {
  final List<MovementEntity> movements;

  const MovementListView(this.movements, {super.key});

  @override
  Widget build(BuildContext context) {
    if (movements.isEmpty) {
      return Text('No movements.');
    } else {
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: movements.length,
        itemBuilder: (ctx, index) {
          final movement = movements[index];
          if (movement.type == MovementType.payment) {
            return PaymentMovementTile(movement);
          }

          if (movement.type == MovementType.maintenanceFee) {
            return MaintenanceFeeMovementTile(movement);
          }

          return MovementTile(movement);
        },
      );
    }
  }
}
