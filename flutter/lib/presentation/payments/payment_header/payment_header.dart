import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';
import 'package:resipal/presentation/payments/approve_payment/approve_payment.dart';
import 'package:resipal/presentation/payments/payment_header/payment_header_cubit.dart';
import 'package:resipal/presentation/payments/payment_icon.dart';
import 'package:resipal/presentation/payments/payment_status_pill.dart';

class PaymentHeader extends StatelessWidget {
  final String paymentId;
  const PaymentHeader({required this.paymentId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentHeaderCubit>(
      create: (ctx) => PaymentHeaderCubit()..initialize(paymentId),
      child: BlocBuilder<PaymentHeaderCubit, PaymentHeaderState>(
        builder: (ctx, state) {
          if (state is InitialState || state is LoadingState) {
            return LoadingView();
          }

          if (state is LoadedState) {
            return _Loaded(payment: state.payment);
          }

          if (state is ErrorState) {
            return ErrorStateView(
              errorMessage: state.errorMessage,
              exception: state.exception,
            );
          }

          return UnknownStateView();
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  final PaymentEntity payment;
  const _Loaded({required this.payment, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                PaymentIcon(payment),
                const SizedBox(height: 16),
                AmountText(CurrencyFormatter.fromCents(payment.amountInCents)),
                const SizedBox(height: 8),
                PaymentStatusPill(payment),
              ],
            ),
          ),
        ),
        if (payment.status == PaymentStatus.pendingReview) ...[
          const SizedBox(height: 12),
          ApprovePaymentButton(payment: payment),
        ],
      ],
    );
  }
}
