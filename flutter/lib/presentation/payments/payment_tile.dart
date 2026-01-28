import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/presentation/payments/payment_details_page.dart';
import 'package:resipal/presentation/payments/payment_icon.dart';
import 'package:resipal/presentation/payments/payment_status_pill.dart';
import 'package:short_navigation/short_navigation.dart';

class PaymentTile extends StatelessWidget {
  final PaymentEntity payment;
  const PaymentTile(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      onTap: () => Go.to(PaymentDetailsPage(payment)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AmountText.fromCents(
            payment.amountInCents,
            fontSize: 32.0,
            fontWeight: FontWeight.normal,
          ),

          Spacer(),
          Column(
            children: [
              PaymentStatusPill(payment),
              SizedBox(height: 8.0),
              BodyText.tiny(payment.date.toShortDate()),
            ],
          ),
          SizedBox(width: 12.0),

          Icon(Icons.arrow_forward_ios),
          // NExt
        ],
      ),
    );
  }
}
