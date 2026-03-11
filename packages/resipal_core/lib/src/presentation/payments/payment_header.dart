import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class PaymentHeader extends StatelessWidget {
  final PaymentEntity payment;
  const PaymentHeader(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GradientCard(
      child: Column(
        children: [
          // Using a white-themed version of your icon/status for the gradient
          PaymentIcon(payment),
          const SizedBox(height: 24),

          OverlineText('Monto de la transacción', color: colorScheme.onPrimary.withOpacity(0.7)),
          const SizedBox(height: 8),
          AmountText(
            amountInCents: payment.amountInCents,
            fontSize: 36,
            // Keeping it white for maximum contrast on the primary gradient
            color: colorScheme.onPrimary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Reusing your existing pill but ensuring it pops against the background
          PaymentStatusPill(payment),

          const SizedBox(height: 16),
          Divider(height: 1, color: colorScheme.onPrimary.withOpacity(0.2)),
          const SizedBox(height: 16),

          BodyText.small(
            'Referencia: ${payment.id.substring(0, 8).toUpperCase()}',
            color: colorScheme.onPrimary.withOpacity(0.6),
          ),
        ],
      ),
    );
  }
}
