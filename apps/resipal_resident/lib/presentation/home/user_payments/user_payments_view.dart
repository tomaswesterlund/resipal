import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/presentation/payments/pages/register_payment/register_payment_page.dart';
import 'package:resipal_core/presentation/payments/views/payment_list_view.dart';
import 'package:resipal_core/presentation/shared/buttons/cta/primary_cta_button.dart';
import 'package:resipal_core/presentation/shared/cards/shimmer_card.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/containers/green_box_container.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/unknown_state_view.dart';
import 'package:resipal_user/presentation/home/user_payments/user_payments_cubit.dart';
import 'package:resipal_user/presentation/home/user_payments/user_payments_state.dart';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderText.four('Mis últimos pagos'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Ver todos >',
                          style: GoogleFonts.raleway(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: BaseAppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  BlocBuilder<UserPaymentsCubit, UserPaymentsState>(
                    builder: (ctx, state) {
                      if (state is InitialState || state is LoadingState) {
                        return const _Loading();
                      }

                      if (state is LoadedState) {
                        return _Loaded(state.payments);
                      }

                      if (state is ErrorState) {
                        return const ErrorView();
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
    return Column(
      children: const [ShimmerCard(), ShimmerCard(), ShimmerCard()],
    );
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
