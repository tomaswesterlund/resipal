import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/cards/shimmer_card.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/payments/payment_list_view.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_page.dart';
import 'package:resipal/presentation/users/home/user_payments/user_payments_cubit.dart';
import 'package:resipal/presentation/users/home/user_payments/user_payments_state.dart';
import 'package:short_navigation/short_navigation.dart';

class UserPaymentsView extends StatelessWidget {
  final UserEntity user;
  const UserPaymentsView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserPaymentsCubit()..intialize(user.id),
      child: BlocBuilder<UserPaymentsCubit, UserPaymentsState>(
        builder: (ctx, state) {
          if (state.isError) {
            return ErrorStateView(errorMessage: state.errorMessage, exception: state.exception);
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GreenBoxContainer(
                  child: SafeArea(
                    child: Column(
                      children: [
                        HeaderText.one('Mis pagos', color: Colors.white),
                        const SizedBox(height: 12.0),
                        PrimaryCtaButton(label: 'Registrar pago', canSubmit: true, onPressed: () => Go.to(const RegisterPaymentPage())),
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
                      PrimaryCtaButton(label: 'Registrar pago', canSubmit: true, onPressed: () => Go.to(const RegisterPaymentPage())),

                      SizedBox(height: 32),

                      HeaderText.four('Mis Pagos', textAlign: TextAlign.start),
                      if (state.isFetchingPayments) ...[
                        ShimmerCard(),
                        ShimmerCard(),
                        ShimmerCard(),
                      ] else ...[
                        const SizedBox(height: 12),
                        PaymentListView(state.payments),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 148),
              ],
            ),
          );
        },
      ),
    );
  }
}
