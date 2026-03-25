import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';

class MemberHeader extends StatelessWidget {
  final MemberEntity member;

  const MemberHeader({required this.member, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    return GradientCard(
      child: Column(
        children: [
          // Sección Superior: Icono y Nombre
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: HeaderText.two(
                  member.name,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 20),

          // Métricas Financieras
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     _buildFinanceItem(
          //       'SALDO TOTAL',
          //       member.totalMemberBalanceInCents,
          //       onPrimary,
          //     ),
          //     _buildFinanceItem(
          //       'POR REVISAR',
          //       member.paymentLedger.pendingPaymentAmountInCents,
          //       onPrimary,
          //       accentColor: Colors.orangeAccent,
          //     ),
          //     _buildFinanceItem(
          //       'DEUDA',
          //       member.propertyRegistry.totalDebtAmountInCents,
          //       onPrimary,
          //       accentColor: Colors.redAccent,
          //     ),
          //   ],
          // ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 16),

          // Sección Inferior: Info de Comunidad y Roles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('COMUNIDAD', color: Colors.white),
                    const SizedBox(height: 2),
                    BodyText.small(
                      member.community.name,
                      color: onPrimary.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('ROLES ACTIVOS', color: Colors.white),
                  const SizedBox(height: 4),
                  _buildRoleIcons(context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceItem(String label, int cents, Color baseColor, {Color? accentColor}) {
    return Expanded(
      child: Column(
        children: [
          OverlineText(label, color: baseColor.withOpacity(0.7)),
          const SizedBox(height: 4),
          AmountText(
            amountInCents: cents,
            fontSize: 16,
            color: (cents != 0 && accentColor != null) ? accentColor : baseColor,
          ),
        ],
      ),
    );
  }

  Widget _buildRoleIcons(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (member.isAdmin) 
          _buildHeaderIcon(Icons.admin_panel_settings_rounded, onPrimary),
        if (member.isSecurity) 
          _buildHeaderIcon(Icons.shield_outlined, onPrimary),
        if (member.isResident) 
          _buildHeaderIcon(Icons.home_work_outlined, onPrimary),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Icon(icon, size: 20, color: color.withOpacity(0.9)),
    );
  }
}