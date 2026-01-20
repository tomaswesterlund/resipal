import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/movement_entity.dart';

class PaymentMovementTile extends StatelessWidget {
  final MovementEntity movement;
  const PaymentMovementTile(this.movement, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Soft green shadow or border could be added here to distinguish it further
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Payment-specific icon styling
            const Icon(
              Icons.receipt_long_rounded,
              size: 36,
              color: Color(0xFF2E7D32), // Success green
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText.five('Pago Registrado'),
                HeaderText.six(
                  'Fecha: ${movement.date.toShortDate()}',
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Displaying as positive green amount
                AmountText.fromDouble(
                  movement.amountInCents.toDouble(),
                  fontSize: 14,
                  color: const Color(0xFF2E7D32),
                ),
                const Text(
                  'Aplicado',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}