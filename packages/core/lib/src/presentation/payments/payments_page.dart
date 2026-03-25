import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/my_app_bar.dart';

class PaymentsPage extends StatelessWidget {
  final PaymentLedgerEntity ledger;
  const PaymentsPage({required this.ledger, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Pagos',
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(RegisterPaymentPage()))],
      ),
      body: PaymentListView(ledger.payments),
    );
  }
}
