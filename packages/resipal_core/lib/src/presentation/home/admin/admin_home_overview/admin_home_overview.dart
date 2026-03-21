import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/entities/members/admin_member_entity.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class AdminHomeOverview extends StatelessWidget {
  final AdminMemberEntity admin;
  final CommunityEntity community;
  final VoidCallback onPendingPaymentsPressed;
  final VoidCallback onPendingApplicationsPressed;

  const AdminHomeOverview({
    required this.admin,
    required this.community,
    required this.onPendingPaymentsPressed,
    required this.onPendingApplicationsPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => AdminHomeOverviewCubit()..initialize(community, admin),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: BlocBuilder<AdminHomeOverviewCubit, AdminHomeOverviewState>(
          builder: (context, state) {
            if (state is AdminHomeOverviewLoadingState) return const LoadingView();
            if (state is AdminHomeOverviewErrorState) return const ErrorView();

            if (state is AdminHomeOverviewLoadedState) {
              final community = state.community;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- SALUDO Y COMUNIDAD ---
                    HeaderText.four('¡Bienvenido, ${state.admin.name.split(' ')[0]}!'),
                    const SizedBox(height: 4),
                    Text(
                      community.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colorScheme.outline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- HEADER FINANCIERO GLOBAL ---
                    CommunityFinanceHeader(community: community),

                    const SizedBox(height: 16),

                    // --- HEADER DE INFRAESTRUCTURA ---
                    CommunityPropertyHeader(community: community),

                    const SizedBox(height: 32),

                    HeaderText.five('Acciones Pendientes'),
                    const SizedBox(height: 16),

                    ActionTile(
                      title: 'Pagos por revisar',
                      count: community.paymentLedger.pendingPayments.length,
                      icon: Icons.receipt_long_outlined,
                      color: colorScheme.surfaceTint,
                      onPressed: () => Go.to(PaymentsPage(ledger: community.paymentLedger)),
                    ),
                    const SizedBox(height: 12),
                    ActionTile(
                      title: 'Solicitudes de ingreso',
                      count: community.applications.length,
                      icon: Icons.person_add_outlined,
                      color: colorScheme.surfaceTint,
                      onPressed: () => Go.to(ApplicationListPage(applications: community.applications)),
                    ),

                    const SizedBox(height: 200),
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

/// Header que muestra Saldo Total y Deuda Vencida de la Comunidad
class CommunityFinanceHeader extends StatelessWidget {
  final CommunityEntity community;
  const CommunityFinanceHeader({required this.community, super.key});

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      child: Column(
        children: [
          const OverlineText('SALDO TOTAL EN CAJA', color: Colors.white70),
          const SizedBox(height: 4),
          AmountText(amountInCents: community.totalBalanceInCents, fontSize: 42, color: Colors.white),
          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OverlineText('DEUDA VENCIDA', color: Colors.white70),
                  const SizedBox(height: 4),
                  AmountText(
                    amountInCents: community.propertyRegistry.totalDebtAmountInCents,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('PAGOS PENDIENTES', color: Colors.white70),
                  const SizedBox(height: 4),
                  AmountText(
                    amountInCents: community.paymentLedger.pendingPaymentAmountInCents,
                    fontSize: 20,
                    color: Colors.white,
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

/// Header que muestra Conteo de Propiedades y Miembros
class CommunityPropertyHeader extends StatelessWidget {
  final CommunityEntity community;
  const CommunityPropertyHeader({required this.community, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMiniStat(context, Icons.home_work_outlined, community.propertyRegistry.count.toString(), 'PROPIEDADES'),
          Container(width: 1, height: 40, color: Colors.grey.withOpacity(0.2)),
          _buildMiniStat(context, Icons.people_alt_outlined, community.memberDirectory.count.toString(), 'MIEMBROS'),
        ],
      ),
    );
  }

  Widget _buildMiniStat(BuildContext context, IconData icon, String value, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 28),
        const SizedBox(height: 8),
        HeaderText.three(value),
        OverlineText(label, color: theme.colorScheme.outline),
      ],
    );
  }
}
