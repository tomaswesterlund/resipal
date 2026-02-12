import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/inputs/email_input_field.dart';
import 'package:resipal/core/ui/inputs/phone_number_input_field.dart';
import 'package:resipal/core/ui/inputs/text_input_field.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/success_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_cubit.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_form_state.dart';
import 'package:resipal/presentation/users/user_onboarding/user_data/user_onboarding_user_data_state.dart';

class UserOnboardingUserDataPage extends StatelessWidget {
  final Function(UserEntity) onUserCreated;

  const UserOnboardingUserDataPage({required this.onUserCreated, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: MyAppBar(title: 'Onboarding', automaticallyImplyLeading: false),
      body: BlocProvider<UserOnboardingUserDataCubit>(
        create: (ctx) => UserOnboardingUserDataCubit(onUserCreated: onUserCreated)..initialize(),
        child: BlocBuilder<UserOnboardingUserDataCubit, UserOnboardingUserDataState>(
          builder: (ctx, state) {
            if (state is InitialState) {
              return LoadingView();
            }

            if (state is FormSubmittingState) {
              return LoadingView(title: 'Procesando ...');
            }

            if (state is FormEditingState) {
              return _Form(state.formState);
            }

            if (state is FormSubmittedSuccessfullyState) {
              return SuccessView(
                title: '¡Bienvenido a Resipal!',
                subtitle: 'Tu cuenta ha sido creada exitosamente.',
                actionButtonLabel: 'CONTINUAR',
                onActionButtonPressed: () => onUserCreated(state.user),
              );
            }

            if (state is ErrorState) {
              return ErrorStateView();
            }

            return UnknownStateView();
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final UserOnboardingUserDataFormState formState;
  const _Form(this.formState, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserOnboardingUserDataCubit>();
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 16),
          HeaderText.three('¡Casi listo! 👋', textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: BodyText.medium(
              'Para brindarte la mejor experiencia en tu comunidad, necesitamos algunos detalles básicos para completar tu perfil.',
              textAlign: TextAlign.center,
              color: AppColors.hintText,
            ),
          ),
          const SizedBox(height: 32.0),
          // BodyText.medium('Por favor, ingresa tus datos de contacto.'),
          // const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              child: Column(
                children: [
                  TextInputField(
                    label: 'Nombre',
                    hint: 'Nombre',
                    initialValue: formState.name,
                    onChanged: cubit.updateName,
                  ),
                  const SizedBox(height: 12.0),
                  PhoneNumberInputField(
                    label: 'Número de teléfono',
                    initialValue: formState.phoneNumber,
                    onChanged: cubit.updatePhoneNumber,
                  ),
                  const SizedBox(height: 12.0),
                  PhoneNumberInputField(
                    label: 'Número de emergencia',
                    initialValue: formState.emergencyPhoneNumber,
                    onChanged: cubit.updateEmergencyPhoneNumber,
                  ),
                  const SizedBox(height: 12.0),
                  EmailInputField(label: 'Correo electrónico', initialValue: formState.email, enabled: false),
                  const SizedBox(height: 36.0),
                  PrimaryCtaButton(label: 'Enviar', onPressed: cubit.submit, canSubmit: formState.isValid()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
