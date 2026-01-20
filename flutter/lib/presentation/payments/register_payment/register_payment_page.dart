import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/inputs/amount_input_field.dart';
import 'package:resipal/core/ui/inputs/text_input_field.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_cubit.dart';

class RegisterPaymentPage extends StatelessWidget {
  const RegisterPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeaderText.two('Registrar un pago')),
      body: BlocProvider<RegisterPaymentCubit>(
        create: (ctx) => RegisterPaymentCubit()..setup(),
        child: BlocBuilder<RegisterPaymentCubit, RegisterPaymentState>(
          builder: (ctx, state) {
            if (state is FormEditingState) {
              return _Form(state.formState);
            }

            if(state is FormSubmittingState) {
              return LoadingView();
            }

            if(state is ErrorState) {
              return ErrorStateView(errorMessage: state.errorMessage, exception: state.exception,);
            }

            return UnknownStateView();
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final RegisterPaymentFormState formState;
  const _Form(this.formState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountInputField(
            controller: context.read<RegisterPaymentCubit>().amountController,
          ),
          SizedBox(height: 12.0),
          TextInputField(
            label: 'Referencia',
            controller: context
                .read<RegisterPaymentCubit>()
                .referenceController,
          ),
          SizedBox(height: 12.0),
          TextInputField(
            label: 'Nota',
            controller: context.read<RegisterPaymentCubit>().noteController,
          ),
          SizedBox(height: 24.0),
          HeaderText.four('Comprobante'),
          BodyText.small(
            'Selecciona la opción para elegir una imagen o tomar una nueva.',
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BoxBorder.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        Text('Tomar foto'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BoxBorder.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.add_photo_alternate_outlined),
                        Text('Seleccionar foto'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Center(
            child: BodyText.tiny(
              'Solo se aceptan imagenes de la transferencia o deposito.',
            ),
          ),

          SizedBox(height: 24.0),
          Center(
            child: PrimaryCtaButton(
              label: 'ENVIAR PAGO',
              canSubmit: formState.canSubmit,
              onPressed: () => context.read<RegisterPaymentCubit>().submit(),
            ),
          ),
        ],
      ),
    );
  }
}
