import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wester_kit/lib.dart';
import 'send_whatsapp_message_cubit.dart';
import 'send_whatsapp_message_state.dart';
import 'send_whatsapp_message_form_state.dart';

class SendWhatsappMessagePage extends StatelessWidget {
  const SendWhatsappMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendWhatsappMessageCubit()..initialize(),
      child: Scaffold(
        appBar: const MyAppBar(title: 'Enviar WhatsApp'),
        body: BlocBuilder<SendWhatsappMessageCubit, SendWhatsappMessageState>(
          builder: (context, state) {
            if (state is SendWhatsappMessageSubmittingState) {
              return const LoadingView(title: 'Enviando mensaje...');
            }

            if (state is SendWhatsappMessageSuccessState) {
              return SuccessView(
                title: '¡Mensaje enviado!',
                actionButtonLabel: 'VOLVER',
                onActionButtonPressed: () => Navigator.of(context).pop(),
              );
            }

            if (state is SendWhatsappMessageFormEditingState) {
              return _WhatsappForm(formState: state.formState);
            }

            if (state is SendWhatsappMessageErrorState) {
              return ErrorView(
                // message: state.error,
                // onRetry: () => context.read<SendWhatsappMessageCubit>().initialize(),
              );
            }

            return const UnknownStateView();
          },
        ),
      ),
    );
  }
}

class _WhatsappForm extends StatelessWidget {
  final SendWhatsappMessageFormState formState;
  const _WhatsappForm({required this.formState});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SendWhatsappMessageCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderText.five('Nuevo Mensaje'),
          const SizedBox(height: 8),
          BodyText.medium('Ingresa los datos para enviar una notificación vía WhatsApp.'),
          const SizedBox(height: 32),

          TextInputField(
            label: 'Número de Teléfono',
            hint: 'Ej: +52 55 1234 5678',
            isRequired: true,
            prefixIcon: Icon(Icons.phone_android_rounded),
            keyboardType: TextInputType.phone,
            onChanged: cubit.updatePhoneNumber,
          ),

          const SizedBox(height: 24),

          TextInputField(
            label: 'Mensaje',
            hint: 'Escribe tu mensaje aquí...',
            isRequired: true,
            maxLines: 4,
            onChanged: cubit.updateMessage,
          ),

          const SizedBox(height: 40),

          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Enviar WhatsApp',
              canSubmit: formState.canSubmit,
              onPressed: () => cubit.submit(),
            ),
          ),
        ],
      ),
    );
  }
}
