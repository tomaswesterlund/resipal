import 'package:flutter/material.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/movements/widgets/movement_list_view.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_page.dart';
import 'package:short_navigation/short_navigation.dart';

class UserMovementsView extends StatelessWidget {
  final UserEntity user;
  const UserMovementsView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return _Loaded(user.movements);
  }
}

class _Loaded extends StatelessWidget {
  final List<MovementEntity> movements;
  const _Loaded(this.movements, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GreenBoxContainer(
            child: Column(
              children: [
                SizedBox(height: 24.0),
                HeaderText.one('Saldo total', color: Colors.white),
                AmountText.fromDouble(1500.23, color: Colors.white),
                HeaderText.six(
                  '✅ Estas al corriente',
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
                SizedBox(height: 24.0),

                PrimaryCtaButton(
                  label: 'Registrar pago',
                  canSubmit: true,
                  onPressed: () => Go.to(RegisterPaymentPage()),
                ),
              ],
            ),
          ),
          Text('PROPERTY SELECTOR'),
          HeaderText.three('Mis movimientos'),
          MovementListView(movements),
        ],
      ),
    );
  }
}
