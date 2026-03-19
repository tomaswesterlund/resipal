import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/src/presentation/shared/loading_screen.dart';
import 'package:resipal_core/lib.dart';
import 'package:resident/presentation/auth/auth_gate_cubit.dart';
import 'package:resident/presentation/auth/auth_gate_state.dart';
import 'package:resident/presentation/signin/signin_page.dart';
import 'package:wester_kit/lib.dart';

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
              title: 'Resipal',
              subtitle: 'Resident',
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
          if (state is AuthGateUserHasNoResidentMembership) {
            return const _UserHasNoResidentMembership();
          }

          // 5. Success -> The Main Admin Dashboard
          if (state is UserSignedIn) {
            final community = GetCommunityById().call(state.resident.community.id);
            return ResidentHomePage(community: community, resident: state.resident);
          }

          if (state is AuthGateErrorState) return const ErrorView();

          return const UnknownStateView();
        },
      ),
    );
  }
}

class _UserHasNoResidentMembership extends StatelessWidget {
  const _UserHasNoResidentMembership();

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

          HeaderText.four('Esperando Solicitud', textAlign: TextAlign.center, color: colorScheme.primary),
          const SizedBox(height: 16),

          Text(
            'Para acceder a las funciones de residente, un administrador de tu comunidad debe enviarte una solicitud de ingreso.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.5),
          ),

          const SizedBox(height: 12),

          Text(
            'Una vez que recibas la invitación, podrás ver toda la información de tu propiedad aquí mismo.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.outline),
          ),

          const SizedBox(height: 48),

          // Sección de Soporte / Ayuda
          Divider(color: colorScheme.outlineVariant.withOpacity(0.5)),
          const SizedBox(height: 32),

          Column(
            children: [
              Text(
                '¿Crees que hay un error?',
                style: theme.textTheme.labelMedium?.copyWith(color: colorScheme.outline, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SupportIcon(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Contactar Admin',
                    onTap: () {
                      // Lógica para contactar soporte o admin
                    },
                  ),
                  const SizedBox(width: 48),
                  _SupportIcon(
                    icon: Icons.refresh_rounded,
                    label: 'Actualizar',
                    onTap: () {
                      // Lógica para recargar el estado del usuario
                    },
                  ),
                ],
              ),
            ],
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
