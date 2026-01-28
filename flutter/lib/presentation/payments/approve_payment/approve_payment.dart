import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/presentation/payments/approve_payment/approve_payment_cubit.dart';

class ApprovePaymentButton extends StatelessWidget {
  final PaymentEntity payment;
  const ApprovePaymentButton({required this.payment, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApprovePaymentCubit>(
      create: (ctx) => ApprovePaymentCubit(),
      child: BlocBuilder<ApprovePaymentCubit, ApprovePaymentState>(
        builder: (ctx, state) {
          

          if(state is LoadingState) {
            return PrimaryCtaButton(label: 'Procesando ...', canSubmit: false, onPressed: () {});
          }

          if(state is LoadedState) {
            return PrimaryCtaButton(label: 'Aprobar pago', canSubmit: true, onPressed: () => ctx.read<ApprovePaymentCubit>().submit(payment.id));
          }

          if(state is ErrorState) {
            return ErrorStateView(errorMessage: state.errorMessage, exception: state.exception,);
          }

          return UnknownStateView();
          
        },
      ),
    );
  }
}
