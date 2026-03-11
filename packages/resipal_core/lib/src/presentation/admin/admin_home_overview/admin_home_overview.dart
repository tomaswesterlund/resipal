import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class HomeOverview extends StatelessWidget {
  final CommunityEntity community;
  final UserEntity user;
  final VoidCallback onPendingPaymentsPressed;
  final VoidCallback onPendingApplicationsPressed;

  const HomeOverview({
    required this.community,
    required this.user,
    required this.onPendingPaymentsPressed,
    required this.onPendingApplicationsPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => HomeOverviewCubit()..initialize(community, user),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: BlocBuilder<HomeOverviewCubit, AdminHomeOverviewState>(
          builder: (context, state) {
            if (state is AdminHomeOverviewLoadingState) return const LoadingView();
            if (state is AdminHomeOverviewErrorState) return const ErrorView();

            if (state is AdminHomeOverviewLoadedState) {
              final community = state.community;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText.four('¡Bienvenido, ${state.user.name}!'),
                    const SizedBox(height: 4),
                    Text(
                      community.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colorScheme.outline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            label: 'Propiedades',
                            value: community.propertyRegistry.count.toString(),
                            icon: Icons.home_work_outlined,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: StatCard(
                            label: 'Usuarios',
                            value: community.memberDirectory.length.toString(),
                            icon: Icons.people_outline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(label: 'Balance total', value: '-1', icon: Icons.home_work_outlined),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: StatCard(
                            label: 'Deuda vencida',
                            value: CurrencyFormatter.fromCents(community.propertyRegistry.totalDebtAmountInCents),
                            icon: Icons.home_work_outlined,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),

                    HeaderText.five('Acciones Pendientes'),
                    const SizedBox(height: 12),

                    ActionTile(
                      title: 'Pagos por revisar',
                      count: community.paymentLedger.pendingPayments.length,
                      icon: Icons.receipt_long_outlined,
                      // Replaces AppColors.warning with Terracotta/Secondary
                      color: colorScheme.surfaceTint,
                      onPressed: onPendingPaymentsPressed,
                    ),
                    const SizedBox(height: 12),
                    ActionTile(
                      title: 'Solicitudes de ingreso',
                      count: community.applications.length,
                      icon: Icons.person_add_outlined,
                      // Replaces AppColors.info with System/Info Tertiary
                      color: colorScheme.surfaceTint,
                      onPressed: onPendingApplicationsPressed,
                    ),

                    const SizedBox(height: 48),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
