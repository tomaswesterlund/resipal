import 'package:core/src/presentation/roles/role_selector_card.dart';
import 'package:core/src/presentation/roles/roles_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/lib.dart';
import 'package:core/src/presentation/home/admin/admin_home_page/admin_home_page.dart';
import 'package:ui/lib.dart';
import 'package:short_navigation/short_navigation.dart';

class OnboardingCommunityRegistrationPage extends StatelessWidget {
  const OnboardingCommunityRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const MyAppBar(title: 'Nueva Comunidad', automaticallyImplyLeading: false),
      body: BlocProvider(
        create: (context) => OnboardingCommunityRegistrationCubit()..initialize(),
        child: BlocBuilder<OnboardingCommunityRegistrationCubit, OnboardingCommunityRegistrationState>(
          builder: (context, state) {
            if (state is OnboardingCommunityRegistrationFormSubmittingState) {
              return const LoadingView(
                title: 'Creando tu comunidad',
                description: 'Estamos configurando el espacio digital para tus residentes.',
              );
            }

            if (state is OnboardingCommunityRegistrationFormSubmittedSuccessfully) {
              return SuccessView(
                title: '¡Comunidad Creada!',
                subtitle: 'El registro ha sido exitoso. Ahora puedes empezar a registrar propiedades y pagos.',
                actionButtonLabel: 'Continuar',
                onActionButtonPressed: () {
                  Go.to(AdminHomePage(admin: state.admin, community: state.community));
                },
              );
            }

            if (state is OnboardingCommunityRegistrationErrorState) return const ErrorView();

            if (state is OnboardingCommunityRegistrationFormEditingState) {
              return _Form(state.formstate);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final OnboardingCommunityRegistrationFormState formState;
  const _Form(this.formState);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<OnboardingCommunityRegistrationCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderText.five('Datos de la Comunidad', color: colorScheme.primary),
          const SizedBox(height: 8),
          Text(
            'Define el nombre y la ubicación de la comunidad que vas a administrar.',
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
          ),
          const SizedBox(height: 32),

          TextInputField(
            label: 'Nombre de la Comunidad',
            hint: 'Ej: Residencial Los Olivos',
            isRequired: true,
            errorText: formState.name.errorMessage,
            onChanged: cubit.onNameChanged,
          ),
          const SizedBox(height: 20),

          TextInputField(
            label: 'Ubicación / Dirección',
            hint: 'Calle, número, colonia...',
            isRequired: true,
            errorText: formState.address.errorMessage,
            onChanged: cubit.onAddressChanged,
          ),
          const SizedBox(height: 20),

          TextInputField(
            label: 'Descripción (Opcional)',
            hint: 'Breve descripción o referencia de la comunidad...',
            maxLines: 3,
            errorText: formState.location.errorMessage,
            onChanged: cubit.onDescriptionChanged,
          ),

          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: InputLabel(label: 'Configuración de Roles Iniciales', isRequired: true),
          ),
          Padding(padding: const EdgeInsets.all(8.0), child: RolesView()),
          _RolesSection(formState),

          const SizedBox(height: 48),

          SizedBox(
            width: double.infinity,
            child: PrimaryButton(label: 'CREAR COMUNIDAD', onPressed: cubit.submit),
          ),
        ],
      ),
    );
  }
}

class _RolesSection extends StatelessWidget {
  final OnboardingCommunityRegistrationFormState formState;
  const _RolesSection(this.formState);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCommunityRegistrationCubit>();

    return RoleSelectorCard(
      isResident: formState.isResident,
      isAdmin: true,
      isSecurity: formState.isSecurity,
      errorText: formState.rolesError,
      onResidentChanged: cubit.toggleResident,
      onAdminChanged: (val) {},
      onSecurityChanged: cubit.toggleSecurity,
    );
  }
}
