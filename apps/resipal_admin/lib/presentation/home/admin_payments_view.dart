import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/payment_ledger_entity.dart';
import 'package:resipal_core/presentation/payments/views/payment_list_view.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';

class AdminPaymensView extends StatelessWidget {
  final PaymentLedgerEntity ledger;
  
  const AdminPaymensView(this.ledger, {super.key});

  @override
  Widget build(BuildContext context) {
    if (ledger.payments.isEmpty) {
      return Center(
        child: BodyText.medium(
          'No se encontraron pagos registrados.',
          color: Colors.grey.shade600,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: PaymentListView(ledger.payments),
    );
  }
}