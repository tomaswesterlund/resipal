import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';

class OverdueMaintenanceInfoRow extends StatelessWidget {
  final int overdueAmount;

  const OverdueMaintenanceInfoRow({required this.overdueAmount, super.key});

  @override
  Widget build(BuildContext context) {
    // A high-visibility red for the "Urgent" feel
    const urgentRed = Color(0xFFD32F2F);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        // Soft red background makes the whole area "pop"
        color: urgentRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: urgentRed.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded, // Changed to warning icon for urgency
            color: urgentRed,
            size: 16,
          ),
          const SizedBox(width: 6),
          BodyText.tiny(
            'DEUDA VENCIDA: ', 
            color: urgentRed, 
            fontWeight: FontWeight.bold,
          ),
          AmountText.fromCents(
            overdueAmount,
            color: urgentRed,
            fontSize: 12,
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => _showOverdueExplanation(context),
            child: Icon(
              Icons.help_outline_rounded,
              color: urgentRed.withOpacity(0.6),
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showOverdueExplanation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.warning_rounded, color: Color(0xFFD32F2F)),
            const SizedBox(width: 8),
            HeaderText.four('Atención: Deuda Vencida'),
          ],
        ),
        content: BodyText.small(
          'Este monto corresponde a cuotas de mantenimiento expiradas.\n\nEvita recargos adicionales o la suspensión de servicios del residencial realizando tu pago a la brevedad.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'ENTENDIDO',
              style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}