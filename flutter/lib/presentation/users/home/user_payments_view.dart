import 'package:flutter/material.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/presentation/payments/payment_list_view.dart';


// Send in user ID
// Watch User Payments
class UserPaymentsView extends StatelessWidget {
  final List<PaymentEntity> payments;
  const UserPaymentsView(this.payments, {super.key});

  @override
  Widget build(BuildContext context) {
    payments.sort((a, b) => b.date.compareTo(a.date),); 
    return SingleChildScrollView(
      child: Column(
        children: [
          GreenBoxContainer(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: HeaderText.two('Mis pagos', color: Colors.white),
                ),
              ),
            ),
          ),
          PaymentListView(payments),
        ],
      ),
    );
  }
}
