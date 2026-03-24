import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/residents/resident_applications/resident_applications_page.dart';
import 'package:wester_kit/lib.dart';
import 'package:short_navigation/short_navigation.dart';

class ResidentOnboardingPage extends StatelessWidget {
  final ApplicationEntity? application;
  const ResidentOnboardingPage({required this.application, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => ResidentOnboardingCubit()..initialize(application),
      child: BlocListener<ResidentOnboardingCubit, ResidentOnboardingState>(
        listener: (context, state) {},
        child: Scaffold(
          backgroundColor: colorScheme.background,
          appBar: const MyAppBar(title: 'Perfil de Residente', automaticallyImplyLeading: false),
          body: BlocBuilder<ResidentOnboardingCubit, ResidentOnboardingState>(
            builder: (context, state) {
              if (state is ResidentOnboardingInitialState) {
                return Center(child: CircularProgressIndicator(color: colorScheme.primary));
              }

              if (state is ResidentOnboardingFormSubmittingState) {
                return const LoadingView(
                  title: 'Finalizando tu registro',
                  description: 'Estamos configurando tu acceso y preparando tu panel de residente.',
                );
              }

              if (state is ResidentOnboardingFormSubmittedSuccessfully) {
                return SuccessView(
                  title: '¡Perfil creado!',
                  subtitle: 'Tu perfil de residente se ha configurado correctamente.',
                  actionButtonLabel: 'Revisar mis solicitudes',
                  onActionButtonPressed: () {
                    Go.to(ResidentApplicationsPage(user: state.user));
                  },
                );
              }

              if (state is ResidentOnboardingErrorState) {
                return const ErrorView();
              }

              if (state is ResidentOnboardingFormEditingState) {
                final form = state.formstate;
                final cubit = context.read<ResidentOnboardingCubit>();

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText.five('Completa tu perfil', color: colorScheme.primary),
                      const SizedBox(height: 8),
                      BodyText.medium(
                        'Asegúrate de que tus datos sean correctos para recibir notificaciones importantes de tu comunidad.',
                      ),

                      const SizedBox(height: 32),

                      TextInputField(
                        label: 'Nombre completo',
                        hint: 'Ej: Juan Pérez',
                        isRequired: true,
                        initialValue: form.name,
                        helpText: 'Tu nombre tal como aparecerá en el registro de la comunidad.',
                        onChanged: cubit.onNameChanged,
                      ),
                      const SizedBox(height: 20),

                      PhoneNumberInputField(
                        label: 'Teléfono de contacto',
                        hint: 'XX XXXX XXXX',
                        isRequired: true,
                        initialValue: form.phoneNumber,
                        helpText:
                            'Tu número principal para recibir alertas de seguridad y contacto de la administración.',
                        onChanged: cubit.onPhoneChanged,
                      ),
                      const SizedBox(height: 20),

                      TextInputField(
                        label: 'Teléfono de emergencia',
                        hint: 'Ej: 55 8765 4321',
                        isRequired: false,
                        keyboardType: TextInputType.phone,
                        helpText: 'Número de un contacto de confianza en caso de incidentes dentro de la comunidad.',
                        onChanged: cubit.onEmergencyPhoneChanged,
                      ),
                      const SizedBox(height: 20.0),

                      EmailInputField(
                        label: 'Correo electrónicio',
                        isRequired: true,
                        isReadonly: true,
                        initialValue: form.email,
                      ),

                      const SizedBox(height: 48),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: 'Finalizar Registro',
                          onPressed: form.canSubmit ? () => cubit.submit() : null,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
