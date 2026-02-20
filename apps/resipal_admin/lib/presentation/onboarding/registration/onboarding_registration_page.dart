import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_admin/presentation/onboarding/registration/onboarding_registration_cubit.dart';
import 'package:resipal_admin/presentation/onboarding/registration/onboarding_registration_state.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/inputs/phone_number_input_field.dart';
import 'package:resipal_core/presentation/shared/my_app_bar.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/inputs/text_input_field.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/loading_view.dart';
import 'package:resipal_core/presentation/shared/views/success_view.dart';

class OnboardingRegistrationPage extends StatelessWidget {
  const OnboardingRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingRegistrationCubit()..initialize(),
      child: BlocListener<OnboardingRegistrationCubit, OnboardingRegistrationState>(
        listener: (context, state) {},
        child: Scaffold(
          backgroundColor: BaseAppColors.background,
          appBar: const MyAppBar(title: 'Perfil de Administrador', automaticallyImplyLeading: false),
          body: BlocBuilder<OnboardingRegistrationCubit, OnboardingRegistrationState>(
            builder: (context, state) {
              if (state is InitialState || state is FormSubmittingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is FormSubmittingState) {
                return const LoadingView(
                  title: 'Finalizando tu registro',
                  description: 'Estamos configurando tu cuenta de administrador y preparando tu panel de control.',
                );
              }

              if (state is FormSubmittedSuccessfully) {
                return SuccessView(
                  title: '¡Todo listo!',
                  subtitle: 'Tu perfil ha sido creado con éxito. Ya puedes comenzar a gestionar tu comunidad.',
                  actionButtonLabel: 'Ir al Panel Principal',
                  onActionButtonPressed: () {},
                );
              }

              if (state is ErrorState) {
                return ErrorView();
              }

              if (state is FormEditingState) {
                final form = state.formstate;
                final cubit = context.read<OnboardingRegistrationCubit>();

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText.five('Completa tu perfil', color: const Color(0xFF1A4644)),
                      const SizedBox(height: 8),
                      Text(
                        'Estos datos se utilizarán para que los residentes puedan contactarte y para generar tus reportes.',
                        style: GoogleFonts.raleway(fontSize: 14, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 32),

                      TextInputField(
                        label: 'Nombre completo',
                        hint: 'Ej: Juan Pérez',
                        isRequired: true,
                        initialValue: form.name,
                        helpText: 'Tu nombre real como administrador.',
                        onChanged: cubit.onNameChanged,
                      ),
                      const SizedBox(height: 20),

                      PhoneNumberInputField(
                        label: 'Teléfono de contacto',
                        hint: 'XX XXXX XXXX',
                        isRequired: true,
                        initialValue: form.phoneNumber,
                        onChanged: cubit.onPhoneChanged,
                      ),
                      const SizedBox(height: 20),

                      // Read-only Email display
                      _ReadOnlyEmailField(email: form.email),

                      const SizedBox(height: 48),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A4644),
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: form.canSubmit ? () => cubit.submit() : null,
                          child: Text(
                            'Finalizar Registro',
                            style: GoogleFonts.raleway(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
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

class _ReadOnlyEmailField extends StatelessWidget {
  final String email;
  const _ReadOnlyEmailField({required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            'Correo Electrónico',
            style: GoogleFonts.raleway(fontSize: 14.0, fontWeight: FontWeight.w600, color: const Color(0xFF1A4644)),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(email, style: GoogleFonts.raleway(fontSize: 16.0, color: Colors.grey.shade600)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            'El correo está vinculado a tu cuenta.',
            style: GoogleFonts.raleway(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
