import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class MemberCard extends StatelessWidget {
  final MemberEntity member;

  const MemberCard(this.member, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool hasDebt = member.propertyRegistry.hasDebt;
    final Color statusColor = hasDebt ? colorScheme.error : colorScheme.tertiary;

    // Property Label Logic: "Casa 1, Casa 2 y Casa 3"
    final List<String> propertyNames = member.propertyRegistry.properties.map((p) => p.name).toList();
    String propertiesLabel = 'Sin propiedades';

    if (propertyNames.isNotEmpty) {
      if (propertyNames.length == 1) {
        propertiesLabel = propertyNames.first;
      } else {
        final last = propertyNames.removeLast();
        propertiesLabel = '${propertyNames.join(', ')} y $last';
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Branded Status Indicator (Green for good, Red for debt)
              Container(width: 6, color: statusColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Header: Name & Role Icons ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.person, size: 36, color: colorScheme.onPrimaryContainer),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText.five(member.name, color: colorScheme.onSurface),
                                const SizedBox(height: 2),
                                BodyText.tiny(propertiesLabel),
                              ],
                            ),
                          ),
                          _buildRoleBadges(context),
                        ],
                      ),

                      const Divider(height: 24, thickness: 1),

                      // --- Footer: Financial Metrics ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                _buildAmountColumn(
                                  context,
                                  label: 'SALDO',
                                  cents: member.totalMemberBalanceInCents,
                                  color: member.totalMemberBalanceInCents > 0
                                      ? colorScheme.tertiary
                                      : (member.totalMemberBalanceInCents < 0
                                            ? colorScheme.error
                                            : colorScheme.outline),
                                ),
                                SizedBox(width: 10),
                                _buildAmountColumn(
                                  context,
                                  label: 'PAGOS POR REVISAR',
                                  cents: member.paymentLedger.pendingPaymentAmountInCents,
                                  color: member.paymentLedger.pendingPaymentAmountInCents > 0
                                      ? Colors.orange.shade700
                                      : colorScheme.outline,
                                ),
                                SizedBox(width: 10),
                                _buildAmountColumn(
                                  context,
                                  label: 'DEUDA VENCIDA',
                                  cents: member.propertyRegistry.totalDebtAmountInCents,
                                  color: member.propertyRegistry.totalDebtAmountInCents > 0
                                      ? colorScheme.error
                                      : colorScheme.outline,
                                ),
                              ],
                            ),
                          ),

                          ActionLink(
                            label: 'Detalles',
                            onTap: () => Go.to(MemberDetailsPage(member: member)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountColumn(BuildContext context, {required String label, required int cents, required Color color}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 8,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.outline,
          ),
        ),
        AmountText(amountInCents: cents, fontSize: 12, color: color),
      ],
    );
  }

  Widget _buildRoleBadges(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.outline;
    return Row(
      children: [
        if (member.isAdmin) _buildSmallIcon(Icons.admin_panel_settings_outlined, iconColor),
        if (member.isSecurity) _buildSmallIcon(Icons.shield_outlined, iconColor),
        if (member.isResident) _buildSmallIcon(Icons.home_work_outlined, iconColor),
      ],
    );
  }

  Widget _buildSmallIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
