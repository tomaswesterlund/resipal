import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/presentation/payments/payment_tile.dart';

class PaymentListView extends StatelessWidget {
  final List<PaymentEntity> payments;
  const PaymentListView(this.payments, {super.key});

  @override
  Widget build(BuildContext context) {
    if(payments.isEmpty) {
      return HeaderText.six('No pagos registrados ...');
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: payments.length,
        itemBuilder: (ctx, index) {
          final payment = payments[index];
          return PaymentTile(payment);
      });
    }
  }
}