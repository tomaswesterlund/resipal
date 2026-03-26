import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/app_colors.dart';
import 'package:admin/presentation/auth/auth_gate_cubit.dart';
import 'package:admin/presentation/auth/auth_gate_state.dart';
import 'package:admin/presentation/signin/signin_page.dart';
import 'package:core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/support/support_section.dart';
import 'package:ui/lib.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthGateCubit>(
      // Initialize immediately to check session
      create: (ctx) => AuthGateCubit()..initialize(),
      child: BlocBuilder<AuthGateCubit, AuthGateState>(
        builder: (ctx, state) {
          if (state is InitialState || state is LoadingState) {
            return LoadingScreen(
              logoColor: LogoColor.blue,
              title: 'Resipal',
              subtitle: 'Admin',
              loadingTitle: 'Iniciando sesión',
              loadingDescription: 'Estamos configurando tu espacio...',
            );
          }

          if (state is UserNotSignedIn) {
            return const SigninPage();
          }

          if (state is UserNotOnboarded) {
            return const OnboardingStartPage();
          }

          if (state is CommunityNotOnboarded || state is UserHasNoAdminMembership) {
            return const _UserHasNoAdminMembership();
          }

          if (state is UserSignedIn) {
            return AdminHomePage(admin: state.admin, community: state.community);
          }

          if (state is UserIsNotAdmin) return const AccessDeniedView();
          if (state is ErrorState) return Scaffold(body: ErrorView());

          return const UnknownStateView();
        },
      ),
    );
  }
}

class _UserHasNoAdminMembership extends StatelessWidget {
  const _UserHasNoAdminMembership();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.domain_add_rounded, size: 64, color: colorScheme.primary),
            ),
            const SizedBox(height: 32),

            HeaderText.four('Sin comunidad asignada', textAlign: TextAlign.center, color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Tu perfil está listo, pero aún no administras ninguna comunidad. Puedes crear una nueva ahora mismo o esperar a ser invitado a una existente.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline, height: 1.5),
            ),
            const SizedBox(height: 48),

            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: 'Crear una Comunidad',
                onPressed: () => Go.to(const OnboardingCommunityRegistrationPage()),
              ),
            ),

            const SizedBox(height: 48),

            // Support Section
            SupportSection(
              onMessagePressed: () async {
                final whatsappService = WhatsAppService();
                await whatsappService.sendSupportMessage();
              },
              onEmailPressed: () {
                final emailService = EmailService();
                emailService.sendSupportEmail();
              },
            ),
          ],
        ),
      ),
    );
  }
}
