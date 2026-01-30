import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';

class OverdueMaintenanceInfoRow extends StatelessWidget {
  final int overdueAmount;

  const OverdueMaintenanceInfoRow({required this.overdueAmount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.dangerScale[50],
        borderRadius: BorderRadius.circular(20), // More modern, rounded feel
        border: Border.all(
          color: AppColors.dangerScale[200]!, // Slightly deeper border for visibility
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded, // Changed from warning_amber to error_outline
            color: AppColors.dangerScale[600], // Using Danger instead of Primary
            size: 16,
          ),
          const SizedBox(width: 8),
          BodyText.tiny(
            'Monto aduedado: ',
            color: AppColors.dangerScale[700]!,
            fontWeight: FontWeight.bold,
          ),
          AmountText.fromCents(
            overdueAmount,
            color: AppColors.dangerScale[800]!,
            fontSize: 12,
            //fontWeight: FontWeight.bpñ  ,
          ),
          Spacer(),
          // --- The Help Button ---
          GestureDetector(
            onTap: () => _showOverdueExplanation(context),
            behavior: HitTestBehavior.opaque, // Better touch target
            child: Icon(
              Icons.help_outline_rounded,
              color: AppColors.dangerScale[400],
              size: 16,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: AppColors.danger),
            const SizedBox(width: 12),
            Expanded(child: HeaderText.four('Cuotas Vencidas')),
          ],
        ),
        content: BodyText.small(
          'Este monto corresponde a cuotas de mantenimiento que han superado su fecha de vencimiento.\n\nPor favor, regulariza tu situación para evitar cargos por mora o limitaciones en el uso de áreas comunes.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'ENTENDIDO',
              style: TextStyle(
                color: AppColors.dangerScale[700],
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}