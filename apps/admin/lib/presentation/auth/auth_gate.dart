import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_admin/app_colors.dart';
import 'package:resipal_admin/presentation/auth/auth_gate_cubit.dart';
import 'package:resipal_admin/presentation/auth/auth_gate_state.dart';
import 'package:resipal_admin/presentation/signin/signin_page.dart';
import 'package:core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
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
            Column(
              children: [
                Text(
                  '¿Necesitas ayuda con el acceso?',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.outline.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SupportIcon(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'WhatsApp',
                      onTap: () {}, // Implement WhatsApp launch
                    ),
                    const SizedBox(width: 56),
                    _SupportIcon(
                      icon: Icons.email_outlined,
                      label: 'Correo',
                      onTap: () {}, // Implement Mail launch
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
