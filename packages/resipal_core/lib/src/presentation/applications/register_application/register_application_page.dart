import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class RegisterApplicationPage extends StatelessWidget {
  const RegisterApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const MyAppBar(title: 'Nueva Solicitud'),
      backgroundColor: colorScheme.background,
      body: BlocProvider(
        create: (context) => RegisterApplicationCubit()..initialize(),
        child: BlocBuilder<RegisterApplicationCubit, RegisterApplicationState>(
          builder: (context, state) {
            if (state is RegisterApplicationFormSubmittingState) {
              return const LoadingView(title: 'Enviando solicitud...');
            }

            if (state is RegisterApplicationErrorState) return const ErrorView();

            if (state is RegisterApplicationFormSubmittedSuccessfullyState) {
              return SuccessView(
                title: '¡Solicitud Enviada!',
                subtitle: 'La solicitud ha sido registrada y está pendiente de revisión.',
                actionButtonLabel: 'Volver',
                onActionButtonPressed: () => Navigator.of(context).pop(),
              );
            }

            if (state is RegisterApplicationFormEditingState) {
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
  final RegisterApplicationFormState formState;
  const _Form(this.formState);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterApplicationCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInputField(
            label: 'Nombre completo',
            hint: 'Ej: Juan Pérez',
            isRequired: true,
            errorText: formState.name.errorMessage,
            onChanged: cubit.updateName,
          ),
          const SizedBox(height: 20),
          EmailInputField(
            label: 'Correo electrónico',
            isRequired: true,
            errorText: formState.email.errorMessage,
            onChanged: cubit.updateEmail,
          ),
          const SizedBox(height: 20),
          PhoneNumberInputField(
            label: 'Teléfono de contacto',
            isRequired: true,
            helpText: 'Tu número principal para recibir notificaciones.',
            errorText: formState.phoneNumber.errorMessage,
            onChanged: cubit.updatePhoneNumber,
          ),
          const SizedBox(height: 20),
          PhoneNumberInputField(
            label: 'Teléfono de emergencia',
            isRequired: false,
            helpText: 'Número de un contacto de confianza en caso de incidentes dentro de la comunidad.',
            errorText: formState.emergencyPhoneNumber.errorMessage,
            onChanged: cubit.updateEmergencyPhoneNumber,
          ),

          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: InputLabel(
              label: 'Roles solicitados',
              isRequired: true,
              helpText:
                  'Define los permisos que tendrá el usuario. Puedes seleccionar varios roles dependiendo de sus responsabilidades en la comunidad.',
            ),
          ),
          _RolesSection(formState),
          

          const SizedBox(height: 32),
          TextInputField(
            label: 'Mensaje de invitación',
            hint: 'Ej: Hola, te invitamos a unirte a nuestra comunidad. Por favor completa tu registro.',
            maxLines: 3,
            isRequired: true,
            helpText:
                'Este mensaje se enviará al usuario junto con su invitación para darle contexto sobre el acceso a la comunidad.',
                errorText: formState.message.errorMessage,
            onChanged: cubit.updateMessage,
          ),

          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(label: 'ENVIAR SOLICITUD', canSubmit: true, onPressed: cubit.submit),
          ),
        ],
      ),
    );
  }
}

class _RolesSection extends StatelessWidget {
  final RegisterApplicationFormState formState;

  const _RolesSection(this.formState);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterApplicationCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    final hasError = formState.rolesError != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultCard(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: hasError ? colorScheme.error : colorScheme.outlineVariant,
              width: hasError ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              CheckboxListTile(
                title: BodyText.medium('Residente'),
                value: formState.isResident,
                onChanged: cubit.toggleResident,
                activeColor: colorScheme.primary,
              ),
              CheckboxListTile(
                title: BodyText.medium('Administrador'),
                value: formState.isAdmin,
                onChanged: cubit.toggleAdmin,
                activeColor: colorScheme.primary,
              ),
              CheckboxListTile(
                title: BodyText.medium('Seguridad'),
                value: formState.isSecurity,
                onChanged: cubit.toggleSecurity,
                activeColor: colorScheme.primary,
              ),
            ],
          ),
        ),

        // Mostramos el mensaje de error debajo del card
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Text(formState.rolesError!, style: TextStyle(color: colorScheme.error, fontSize: 12)),
          ),
      ],
    );
  }
}
