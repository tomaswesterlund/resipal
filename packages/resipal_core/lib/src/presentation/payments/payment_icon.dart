import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';

class PaymentIcon extends StatelessWidget {
  final PaymentEntity payment;
  final double size;

  const PaymentIcon(this.payment, {this.size = 24, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final Color statusColor = payment.status.color(colorScheme);

    return Container(
      padding: EdgeInsets.all(size * 0.6), // Proportional padding
      decoration: BoxDecoration(color: statusColor.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(Icons.receipt_long_rounded, size: size, color: statusColor),
    );
  }
}
