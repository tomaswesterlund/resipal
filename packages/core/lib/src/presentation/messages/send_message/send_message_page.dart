import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';
import 'send_message_cubit.dart';
import 'send_message_form_state.dart';
import 'send_message_state.dart';

class SendMessagePage extends StatelessWidget {
  const SendMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const MyAppBar(title: 'Enviar Mensaje'),
      backgroundColor: colorScheme.surface,
      body: BlocProvider(
        create: (context) => SendMessageCubit()..initialize(),
        child: BlocBuilder<SendMessageCubit, SendMessageState>(
          builder: (context, state) {
            if (state is SendMessageSubmittingState) {
              return const LoadingView(title: 'Enviando mensaje...');
            }

            if (state is SendMessageErrorState) return const ErrorView();

            if (state is SendMessageSuccessState) {
              return SuccessView(
                title: '¡Mensaje Enviado!',
                subtitle: 'El mensaje ha sido enviado al miembro correctamente.',
                actionButtonLabel: 'Volver',
                onActionButtonPressed: () => Navigator.of(context).pop(),
              );
            }

            if (state is SendMessageFormEditingState) {
              return _Form(state.formState);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final SendMessageFormState formState;
  const _Form(this.formState);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SendMessageCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EntityDropdownField<MemberEntity>(
            label: 'Destinatario',
            items: formState.members,
            itemLabelBuilder: (m) => m.name,
            initialValue: formState.selectedMember.value,
            errorMessage: formState.selectedMember.errorMessage,
            onChanged: cubit.updateMember,
            isRequired: true,
          ),
          const SizedBox(height: 20),
          TextInputField(
            label: 'Asunto',
            hint: 'Ej: Aviso de reunión',
            isRequired: true,
            errorText: formState.title.errorMessage,
            onChanged: cubit.updateTitle,
          ),
          const SizedBox(height: 20),
          TextInputField(
            label: 'Mensaje',
            hint: 'Escribe aquí el contenido del mensaje...',
            maxLines: 5,
            isRequired: true,
            errorText: formState.body.errorMessage,
            onChanged: cubit.updateBody,
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(label: 'ENVIAR MENSAJE', canSubmit: true, onPressed: cubit.submit),
          ),
        ],
      ),
    );
  }
}
