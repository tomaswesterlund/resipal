import 'package:flutter/material.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/enums/movement_types.dart';
import 'package:resipal/presentation/movements/pages/tiles/movement_tile.dart';
import 'package:resipal/presentation/movements/pages/tiles/payment_movement_tile.dart';

class MovementListView extends StatelessWidget {
  final List<MovementEntity> movements;

  const MovementListView(this.movements, {super.key});

  @override
  Widget build(BuildContext context) {
    if (movements.isEmpty) {
      return Text('No movements.');
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: movements.length,
        itemBuilder: (ctx, index) {
          final movement = movements[index];
          if(movement.type == MovementTypes.payment) {
            return PaymentMovementTile(movement);
          }
          
          return MovementTile(movement);
        },
      );
    }
  }
}
