import 'package:flutter/material.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/invitations/invitation_card.dart';
import 'package:resipal/presentation/maintenance/overdue_maintenance_info_row.dart';
import 'package:resipal/presentation/payments/pending_payments_info_row.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_page.dart';
import 'package:resipal/presentation/properties/property_card.dart';
import 'package:short_navigation/short_navigation.dart';

class UserHomeView extends StatelessWidget {
  final UserEntity user;
  const UserHomeView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          GreenBoxContainer(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  HeaderText.one('Saldo total', color: Colors.white),
                  AmountText.fromCents(
                    user.totalBalanceInCents,
                    color: Colors.white,
                  ),

                  // Keep your InfoRows here
                  if (user.totalOverdueFeeInCents > 0) ...[
                    const SizedBox(height: 12.0),
                    OverdueMaintenanceInfoRow(
                      overdueAmount: user.totalOverdueFeeInCents,
                    ),
                  ],
                  if (user.pendingPaymentAmountInCents > 0) ...[
                    const SizedBox(height: 8.0),
                    PendingPaymentsInfoRow(
                      pendingPaymentAmount: user.pendingPaymentAmountInCents,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Actions Grid
                const _QuickActionsGrid(),

                const SizedBox(height: 32),

                // Property Info
                HeaderText.four('Mis Propiedades'),
                const SizedBox(height: 12),
                ...user.properties
                    .map((property) => PropertyCard(property))
                    .toList(),

                const SizedBox(height: 32),

                // Active Invitations / Access
                if (user.activeInvitations.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderText.four('Invitaciones activas'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver todas'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Simple Horizontal Scroll for Invitations
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: user.activeInvitations.length,
                      itemBuilder: (ctx, i) =>
                          InvitationCard(user.activeInvitations[i]),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
