import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/app_colors.dart';

class PendingPaymentsInfoRow extends StatelessWidget {
  final int pendingPaymentAmount;
  const PendingPaymentsInfoRow({required this.pendingPaymentAmount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        // Using Primary 50 (Lightest Orange) for the background
        color: AppColors.primaryScale[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          // Using Primary 100 for a subtle border
          color: AppColors.primaryScale[100]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.history_toggle_off, 
            color: AppColors.primary, // Primary Base (Orange 500)
            size: 14,
          ),
          const SizedBox(width: 6),
          BodyText.tiny(
            'Pagos en revisión: ', 
            color: AppColors.primaryScale[800]!, // Darker orange for readability
          ),
          AmountText.fromCents(
            pendingPaymentAmount,
            color: AppColors.primaryScale[900]!, // Strongest orange for the amount
            fontSize: 12,
          ),
          Spacer(),
          // --- The Help Button ---
          GestureDetector(
            onTap: () => _showReviewExplanation(context),
            child: Icon(
              Icons.help_outline_rounded,
              color: AppColors.primaryScale[400],
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
        // The header text usually looks best with secondary (Teal) or deep auxiliar (Gray)
        title: HeaderText.four('Pagos en revisión', color: AppColors.secondary),
        content: BodyText.small(
          'Este monto corresponde a los comprobantes que has subido pero que aún no han sido validados por administración.\n\nUna vez verificados, se aplicarán automáticamente a tu saldo total.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            child: const Text('ENTENDIDO', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}