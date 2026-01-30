import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/movement_entity.dart';

class MovementTile extends StatelessWidget {
  final MovementEntity movement;
  const MovementTile(this.movement, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Icon(Icons.construction, size: 36),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText.five(movement.type.name.toString()),
              HeaderText.six(
                'Noviembre / Terreno K19',
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AmountText.fromDouble(
                movement.amountInCents.toDouble(),
                fontSize: 14,
              ),
      
              Text('01 Dic'),
            ],
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
