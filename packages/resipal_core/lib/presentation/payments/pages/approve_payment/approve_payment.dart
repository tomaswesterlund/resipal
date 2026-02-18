import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/presentation/payments/pages/approve_payment/approve_payment_cubit.dart';
import 'package:resipal_core/presentation/shared/buttons/cta/primary_cta_button.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/unknown_state_view.dart';

class ApprovePaymentButton extends StatelessWidget {
  final PaymentEntity payment;
  const ApprovePaymentButton({required this.payment, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApprovePaymentCubit>(
      create: (ctx) => ApprovePaymentCubit(),
      child: BlocBuilder<ApprovePaymentCubit, ApprovePaymentState>(
        builder: (ctx, state) {
          if (state is LoadingState) {
            return PrimaryCtaButton(
              label: 'Procesando ...',
              canSubmit: false,
              onPressed: () {},
            );
          }

          if (state is LoadedState) {
            return PrimaryCtaButton(
              label: 'Aprobar pago',
              canSubmit: true,
              onPressed: () =>
                  ctx.read<ApprovePaymentCubit>().submit(payment.id),
            );
          }

          if (state is ErrorState) {
            return ErrorView();
          }

          return UnknownStateView();
        },
      ),
    );
  }
}
