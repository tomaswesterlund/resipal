import 'package:flutter/material.dart';
import 'package:core/lib.dart';

class PaymentStatusPill extends StatelessWidget {
  final PaymentEntity payment;
  const PaymentStatusPill(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.onPrimary.withOpacity(0.2)),
      ),
      child: Text(
        _getLabel().toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
          fontSize: 10,
        ),
      ),
    );
  }

  String _getLabel() {
    switch (payment.status) {
      case PaymentStatus.approved:
        return 'Aprobado';
      case PaymentStatus.pendingReview:
        return 'En Revisión';
      case PaymentStatus.cancelled:
        return 'Cancelado';
      case PaymentStatus.unknown:
        return 'Desconocido';
    }
  }
}
