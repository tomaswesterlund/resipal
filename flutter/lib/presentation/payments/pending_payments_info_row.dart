import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/app_colors.dart';

class PendingPaymentsInfoRow extends StatelessWidget {
  final int amount;
  const PendingPaymentsInfoRow({required this.amount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.warningScale[50], // Soft orange background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.warningScale[100]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule_rounded,
            color: AppColors.warningScale[600],
            size: 16,
          ),
          const SizedBox(width: 8),
          BodyText.tiny(
            'Pagos en revisión: ',
            color: AppColors.warningScale[700]!,
          ),
          AmountText.fromCents(
            amount,
            color: AppColors.warningScale[800]!,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _showReviewExplanation(context),
            child: Icon(
              Icons.help_outline_rounded,
              color: AppColors.warningScale[300],
              size: 16,
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
        // The header text usually looks best with secondary (Teal) or deep auxiliar (Gray)
        title: HeaderText.four('Pagos en revisión', color: AppColors.secondary),
        content: BodyText.small(
          'Este monto corresponde a los comprobantes que has subido pero que aún no han sido validados por administración.\n\nUna vez verificados, se aplicarán automáticamente a tu saldo total.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            child: const Text(
              'ENTENDIDO',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
