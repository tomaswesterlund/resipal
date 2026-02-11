import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/cards/shimmer_card.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/presentation/payments/payment_list_view.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_page.dart';
import 'package:resipal/presentation/users/home/user_payments/user_payments_cubit.dart';
import 'package:resipal/presentation/users/home/user_payments/user_payments_state.dart';
import 'package:short_navigation/short_navigation.dart';

class UserPaymentsView extends StatelessWidget {
  final String userId;
  const UserPaymentsView({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserPaymentsCubit()..intialize(userId),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreenBoxContainer(
              child: SafeArea(
                child: Column(
                  children: [
                    HeaderText.one('Mis pagos', color: Colors.white),
                    const SizedBox(height: 12.0),
                    PrimaryCtaButton(
                      label: 'Registrar pago',
                      canSubmit: true,
                      onPressed: () => Go.to(const RegisterPaymentPage()),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText.four('Mis Pagos'),
                  const SizedBox(height: 12),
                  BlocBuilder<UserPaymentsCubit, UserPaymentsState>(
                    builder: (ctx, state) {
                      if (state is InitialState || state is LoadingState) {
                        return const _Loading();
                      }

                      if (state is LoadedState) {
                        return _Loaded(state.payments);
                      }

                      if (state is ErrorState) {
                        return const ErrorStateView();
                      }

                      return const UnknownStateView();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 148),
          ],
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: const [ShimmerCard(), ShimmerCard(), ShimmerCard()]);
  }
}

class _Loaded extends StatelessWidget {
  final List<PaymentEntity> payments;
  const _Loaded(this.payments, {super.key});

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return Center(
        child: BodyText.medium(
          'No se encontraron pagos registrados.',
          color: Colors.grey.shade600,
          textAlign: TextAlign.center,
        ),
      );
    }
    return PaymentListView(payments);
  }
}
