import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';
import 'package:resipal/presentation/payments/approve_payment/approve_payment.dart';
import 'package:resipal/presentation/payments/payment_icon.dart';
import 'package:resipal/presentation/payments/payment_status_pill.dart';

class PaymentHeader extends StatelessWidget {
  final PaymentEntity payment;
  const PaymentHeader(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DefaultCard(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                PaymentIcon(payment),
                const SizedBox(height: 16),
                AmountText(CurrencyFormatter.fromCents(payment.amountInCents)),
                const SizedBox(height: 8),
                PaymentStatusPill(payment),
              ],
            ),
          ),
        ),
        if (payment.status == PaymentStatus.pendingReview) ...[
          const SizedBox(height: 12),
          ApprovePaymentButton(payment: payment),
        ],
      ],
    );
  }
}
