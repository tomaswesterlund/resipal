import 'package:flutter/material.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/maintenance/overdue_maintenance_info_row.dart';
import 'package:resipal/presentation/payments/pending_payments_info_row.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_page.dart';
import 'package:short_navigation/short_navigation.dart';

class UserHomeView extends StatelessWidget {
  final UserEntity user;
  const UserHomeView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GreenBoxContainer(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  HeaderText.one('Saldo total', color: Colors.white),
                  AmountText.fromCents(
                    user.totalBalanceInCents,
                    color: Colors.white,
                  ),

                  if (user.totalOverdueFeeInCents > 0) ...[
                    const SizedBox(height: 8.0),
                    OverdueMaintenanceInfoRow(
                      overdueAmount: user.totalOverdueFeeInCents,
                    ),
                  ],

                  if (user.pendingPaymentAmountInCents > 0) ...[
                    const SizedBox(height: 8.0),
                    PendingPaymentsInfoRow(
                      pendingPaymentAmount: user.pendingPaymentAmountInCents,
                    ),
                  ],

                  const SizedBox(height: 24.0),
                  PrimaryCtaButton(
                    label: 'Registrar pago',
                    canSubmit: true,
                    onPressed: () => Go.to(const RegisterPaymentPage()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
