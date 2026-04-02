import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/lib.dart';
import 'package:security/presentation/auth/auth_gate_cubit.dart';
import 'package:security/presentation/auth/auth_gate_state.dart';
import 'package:security/presentation/signin/signin_page.dart';
import 'package:ui/lib.dart';
import 'package:ui/support/support_section.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthGateCubit>(
      // Initialize immediately to check session
      create: (ctx) => AuthGateCubit()..initialize(),
      child: BlocBuilder<AuthGateCubit, AuthGateState>(
        builder: (ctx, state) {
          // 1. Loading / Initialization States
          if (state is AuthGateInitialState || state is AuthGateLoadingState) {
            return LoadingScreen(
              logoColor: LogoColor.red,
              title: 'Resipal',
              subtitle: 'Security',
              loadingTitle: 'Iniciando sesión',
              loadingDescription: 'Estamos configurando tu espacio...',
            );
          }

          // 2. Unauthenticated -> Go to Sign In
          if (state is AuthGateUserNotSignedIn) {
            return const SigninPage();
          }

          // 3. Authenticated but No Profile -> Go to Onboarding
          if (state is AuthGateUserNotOnboarded) {
            return const OnboardingStartPage();
          }

          // 4. Profile exists but No Community -> Go to Community Registration
          if (state is AuthGateUserHasNoSecurityMembership) {
            return const _UserHasNoSecurityMembership();
          }

          // 5. Success -> The Main Admin Dashboard
          if (state is UserSignedIn) {
            // final community = GetCommunityById().call(state.resident.community.id);
            return SecurityHomePage();
          }

          if (state is AuthGateErrorState) {
            return const ErrorView();
          }

          return const UnknownStateView();
        },
      ),
    );
  }
}

class _UserHasNoSecurityMembership extends StatelessWidget {
  const _UserHasNoSecurityMembership();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icono de espera/solicitud
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.05), shape: BoxShape.circle),
            child: Icon(Icons.pending_actions_rounded, size: 64, color: colorScheme.primary.withOpacity(0.6)),
          ),
          const SizedBox(height: 32),

          HeaderText.four('Acceso no autorizado', textAlign: TextAlign.center, color: colorScheme.primary),
          const SizedBox(height: 16),

          Text(
            "No tienes ninguna membresía de seguridad vinculada a tu usuario. Para acceder a las funciones de Seguridad, un administrador de tu comunidad debe registrarte dentro de Resipal.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.5),
          ),

          const SizedBox(height: 12),

          Text(
            "Por favor, ponte en contacto con un administrador del fraccionamiento.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.outline),
          ),

          const SizedBox(height: 48),

          // Sección de Soporte / Ayuda
          Divider(color: colorScheme.outlineVariant.withOpacity(0.5)),
          const SizedBox(height: 32),

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
    );
  }
}

class _SupportIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SupportIcon({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Icon(icon, color: colorScheme.primary, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: colorScheme.primary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
