import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/presentation/maintenance/widgets/overdue_maintenance_info_row.dart';
import 'package:resipal_core/presentation/payments/widgets/pending_payments_info_row.dart';
import 'package:resipal_core/presentation/shared/cards/green_box_card.dart';
import 'package:resipal_core/presentation/shared/colors/app_colors.dart';
import 'package:resipal_core/presentation/shared/texts/amount_text.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/loading_view.dart';
import 'package:resipal_core/presentation/shared/views/unknown_state_view.dart';
import 'package:resipal_user/presentation/home/user_active_invitations/user_active_invitations_view.dart';
import 'package:resipal_user/presentation/home/user_home/user_home_cubit.dart';
import 'package:resipal_user/presentation/home/user_home/user_home_header.dart';
import 'package:resipal_user/presentation/home/user_home/user_home_state.dart';
import 'package:resipal_user/presentation/home/user_properties/user_properties_view.dart';

class UserHomeView extends StatelessWidget {
  final String userId;
  const UserHomeView({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserHomeCubit()..initialize(userId),
      child: BlocBuilder<UserHomeCubit, UserHomeState>(
        builder: (ctx, state) {
          if (state is InitialState || state is LoadingState) {
            return LoadingView();
          }

          if (state is LoadedState) {
            return _Loaded(state.user);
          }

          if (state is ErrorState) {
            return ErrorView();
          }

          return UnknownStateView();
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  final UserEntity user;
  const _Loaded(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHomeHeader(user),
            Container(
              color: AppColors.background,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GreenBoxCard(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            HeaderText.two('Saldo actual', color: Colors.white),
                            AmountText.fromCents(
                              user.totalBalanceInCents,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 12.0),
                            OverdueMaintenanceInfoRow(
                              amount: user.totalOverdueFeeInCents,
                            ),
                            const SizedBox(height: 12.0),
                            PendingPaymentsInfoRow(
                              amount: user.pendingPaymentAmountInCents,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Quick Actions Grid
                    //const _QuickActionsGrid(),
                    const SizedBox(height: 32),
                    const HeaderText.three('Mis propiedades'),
                    const SizedBox(
                      height: 16,
                    ), // Spacing between header and content
                    UserPropertiesView(user: user),
                    const SizedBox(height: 32),
                    UserActiveInvitationsView(user: user),
                  ],
                ),
              ),
            ),
            SizedBox(height: 148),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _ActionIcon(
          icon: Icons.qr_code_scanner,
          label: 'Invitación',
          onTap: () {},
        ),
        _ActionIcon(icon: Icons.history, label: 'Historial', onTap: () {}),
        _ActionIcon(icon: Icons.security, label: 'Accesos', onTap: () {}),
        _ActionIcon(icon: Icons.support_agent, label: 'Soporte', onTap: () {}),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blueGrey[800]),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
