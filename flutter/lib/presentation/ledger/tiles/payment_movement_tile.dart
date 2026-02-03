import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';
import 'package:resipal/presentation/payments/payment_details/payment_details_page.dart';
import 'package:short_navigation/short_navigation.dart';

class PaymentMovementTile extends StatelessWidget {
  final MovementEntity movement;
  const PaymentMovementTile(this.movement, {super.key});

  @override
  Widget build(BuildContext context) {
    final payment = movement.data as PaymentEntity;
    final statusData = _getStatusDisplayData(payment.status);

    return GestureDetector(
      onTap: () => Go.to(PaymentDetailsPage(paymentId: payment.id,)),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Icon container with background color based on status
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusData.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  size: 28,
                  color: statusData.color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText.five(
                      payment.reference?.isNotEmpty == true 
                        ? 'Pago: ${payment.reference}' 
                        : 'Pago Registrado',
                    ),
                    HeaderText.six(
                      'Fecha: ${payment.date.toShortDate()}',
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AmountText.fromCents(
                    payment.amountInCents,
                    fontSize: 15,
                    //fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  const SizedBox(height: 4),
                  // Dynamic Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusData.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      statusData.label.toUpperCase(),
                      style: TextStyle(
                        color: statusData.color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to centralize status styling
  _StatusDisplay _getStatusDisplayData(PaymentStatus status) {
    return switch (status) {
      PaymentStatus.approved => const _StatusDisplay(
          label: 'Aprobado',
          color: Color(0xFF2E7D32), // Success Green
        ),
      PaymentStatus.pendingReview => const _StatusDisplay(
          label: 'En Revisión',
          color: Colors.orange,
        ),
      PaymentStatus.cancelled => const _StatusDisplay(
          label: 'Cancelado',
          color: Colors.red,
        ),
      _ => const _StatusDisplay(
          label: 'Desconocido',
          color: Colors.grey,
        ),
    };
  }
}

// Simple private class to hold UI data
class _StatusDisplay {
  final String label;
  final Color color;
  const _StatusDisplay({required this.label, required this.color});
}