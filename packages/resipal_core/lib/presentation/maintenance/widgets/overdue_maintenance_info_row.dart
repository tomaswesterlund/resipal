import 'package:flutter/material.dart';
import 'package:resipal_core/presentation/shared/colors/app_colors.dart';
import 'package:resipal_core/presentation/shared/texts/amount_text.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';

class OverdueMaintenanceInfoRow extends StatelessWidget {
  final int amount;

  const OverdueMaintenanceInfoRow({required this.amount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.dangerScale[50], // Soft red background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dangerScale[100]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: AppColors.dangerScale[600],
            size: 16,
          ),
          const SizedBox(width: 8),
          BodyText.tiny(
            'Monto adeudado: ',
            color: AppColors.dangerScale[700]!,
            fontWeight: FontWeight.bold,
          ),
          AmountText.fromCents(
            amount,
            color: AppColors.dangerScale[800]!,
            fontSize: 12,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _showOverdueExplanation(context),
            child: Icon(
              Icons.help_outline_rounded,
              color: AppColors.dangerScale[300],
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
