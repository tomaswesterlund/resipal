import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';

class PendingPaymentsInfoRow extends StatelessWidget {
  final int pendingPaymentAmount;
  const PendingPaymentsInfoRow({required this.pendingPaymentAmount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.history_toggle_off, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          BodyText.tiny('Pagos en revisión: ', color: Colors.white),
          AmountText.fromCents(
            pendingPaymentAmount,
            color: Colors.white,
            fontSize: 12,
          ),
          const SizedBox(width: 4),
          // --- The Help Button ---
          GestureDetector(
            onTap: () => _showReviewExplanation(context),
            child: Icon(
              Icons.help_outline_rounded,
              color: Colors.white.withOpacity(0.7),
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewExplanation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: HeaderText.four('Pagos en revisión'),
        content: BodyText.small(
          'Este monto corresponde a los comprobantes que has subido pero que aún no han sido validados por administración.\n\nUna vez verificados, se aplicarán automáticamente a tu saldo total.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ENTENDIDO'),
          ),
        ],
      ),
    );
  }
}
