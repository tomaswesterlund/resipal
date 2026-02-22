import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import '../widgets/payment_card.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';

class PaymentListView extends StatelessWidget {
  final List<PaymentEntity> payments;
  const PaymentListView(this.payments, {super.key});

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return HeaderText.six('No pagos registrados ...');
    } else {
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: payments.length,
        itemBuilder: (ctx, index) {
          final payment = payments[index];
          return PaymentCard(payment);
        },
      );
    }
  }
}
