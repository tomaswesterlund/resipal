import 'package:flutter/material.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/presentation/payments/payment_list_view.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_page.dart';
import 'package:short_navigation/short_navigation.dart';

// Send in user ID
// Watch User Payments
class UserPaymentsView extends StatelessWidget {
  final List<PaymentEntity> payments;
  const UserPaymentsView(this.payments, {super.key});

  @override
  Widget build(BuildContext context) {
    payments.sort((a, b) => b.date.compareTo(a.date));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreenBoxContainer(
            child: SafeArea(
              child: Column(
                children: [
                  HeaderText.one('Mis pagos', color: Colors.white),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12.0),
                PrimaryCtaButton(
                  label: 'Registrar pago',
                  canSubmit: true,
                  onPressed: () => Go.to(const RegisterPaymentPage()),
                ),
                
                SizedBox(height: 32),

                HeaderText.four('Mis Pagos', textAlign: TextAlign.start),
                const SizedBox(height: 12),
                PaymentListView(payments),
              ],
            ),
          ),
          SizedBox(height: 148),
        ],
      ),
    );
  }
}
