import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/presentation/movements/widgets/movement_list_view.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_page.dart';
import 'package:resipal/presentation/users/home/user_movements/user_movements_cubit.dart';
import 'package:short_navigation/short_navigation.dart';

class UserMovementsView extends StatelessWidget {
  const UserMovementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserMovementsCubit>(
      create: (ctx) => UserMovementsCubit()..load(),
      child: BlocBuilder<UserMovementsCubit, UserMovementsState>(
        builder: (ctx, state) {
          if (state is LoadedState) {
            return _Loaded(state.movements);
          }

          return UnknownStateView();
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  final List<MovementEntity> movements;
  const _Loaded(this.movements, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(36),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF002B2A), Color(0xFF1A4644)],
                ),
              ),

              child: Column(
                children: [
                  HeaderText.four('Saldo total', color: Colors.white),
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
      ),
    );
  }
}
