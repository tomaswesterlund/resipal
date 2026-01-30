import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/cards/green_box_card.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/maintenance/overdue_maintenance_info_row.dart';
import 'package:resipal/presentation/payments/pending_payments_info_row.dart';
import 'package:resipal/presentation/users/home/user_active_invitations/user_active_invitations_view.dart';
import 'package:resipal/presentation/users/home/user_home/user_home_header.dart';
import 'package:resipal/presentation/users/home/user_properties/user_properties_view.dart';

class UserHomeView extends StatelessWidget {
  final UserEntity user;
  const UserHomeView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHomeHeader(user),

            // Content Section
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

                            InReviewInfoRow(amount: 250000),
                            const SizedBox(height: 12.0),
                            OverdueInfoRow(amount: 500000,),

                            PendingPaymentsInfoRow(
                              pendingPaymentAmount: 250000,
                            ),
                            const SizedBox(height: 12.0),
                            OverdueMaintenanceInfoRow(overdueAmount: -500000),
                          ],
                        ),
                      ),
                    ),

                    // Quick Actions Grid
                    //const _QuickActionsGrid(),
                    const SizedBox(height: 32),
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



class InReviewInfoRow extends StatelessWidget {
  final int amount;

  const InReviewInfoRow({required this.amount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.warningScale[50], // Soft orange background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.warningScale[100]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, color: AppColors.warningScale[600], size: 16),
          const SizedBox(width: 8),
          BodyText.tiny('Pagos en revisión: ', color: AppColors.warningScale[700]!),
          AmountText.fromCents(amount, color: AppColors.warningScale[800]!, fontSize: 12, fontWeight: FontWeight.bold),
          const SizedBox(width: 8),
          Icon(Icons.help_outline_rounded, color: AppColors.warningScale[300], size: 16),
        ],
      ),
    );
  }
}

class OverdueInfoRow extends StatelessWidget {
  final int amount;

  const OverdueInfoRow({required this.amount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.dangerScale[50], // Soft red background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dangerScale[100]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, color: AppColors.dangerScale[600], size: 16),
          const SizedBox(width: 8),
          BodyText.tiny('Monto adeudado: ', color: AppColors.dangerScale[700]!, fontWeight: FontWeight.bold),
          AmountText.fromCents(amount, color: AppColors.dangerScale[800]!, fontSize: 12),
          const SizedBox(width: 8),
          Icon(Icons.help_outline_rounded, color: AppColors.dangerScale[300], size: 16),
        ],
      ),
    );
  }
}