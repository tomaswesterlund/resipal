import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_core/domain/entities/memberships/community_member_entity.dart';
import 'package:resipal_core/presentation/shared/colors/app_colors.dart';
import 'package:resipal_core/presentation/shared/texts/amount_text.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';

class MembershipCard extends StatelessWidget {
  final MembershipEntity member;

  const MembershipCard(this.member, {super.key});

  @override
  Widget build(BuildContext context) {
    // Determine status color based on debt
    final bool hasDebt = true; //member.user.propertyRegistery.hasDebt;
    final Color statusColor = hasDebt ? AppColors.danger : AppColors.secondary;

    // Format property names (e.g., "L143, L147 y L148")
    final List<String> propertyNames = [
      'Prop 1',
      'Prop 2',
      'Prop 3',
    ]; //member.user.propertyRegistery.properties.map((p) => p.name).toList();
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Status Indicator Side Bar
              Container(width: 6, color: statusColor),

              // 2. Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Member Name & Role Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderText.five(member.user.name, color: AppColors.auxiliarScale[900]!),
                                const SizedBox(height: 2),
                                Text(
                                  propertiesLabel,
                                  style: GoogleFonts.raleway(
                                    fontSize: 12,
                                    color: AppColors.auxiliarScale[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildRoleBadges(),
                        ],
                      ),

                      const Divider(height: 24, thickness: 1, color: Color(0xFFF4F5F4)),

                      // Footer: Balance vs Owed
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left: Financial info
                          Row(
                            children: [
                              _buildAmountColumn(
                                label: 'Balance',
                                cents: -1, //member.user.paymentLedger.totalBalanceInCents,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(width: 24),
                              _buildAmountColumn(
                                label: 'Deuda',
                                cents: -1, //member.user.propertyRegistery.totalOverdueFeeInCents.toInt(),
                                color: hasDebt ? AppColors.danger : AppColors.auxiliarScale[800]!,
                              ),
                            ],
                          ),

                          // Right: Action
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.secondary,
                              textStyle: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            onPressed: () {
                              // Go.to(MemberDetailsPage(memberId: member.id));
                            },
                            child: const Row(
                              children: [
                                Text('Ver perfil'),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios, size: 12),
                              ],
                            ),
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

  Widget _buildAmountColumn({required String label, required int cents, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.raleway(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.auxiliarScale[400]),
        ),
        AmountText.fromCents(cents, fontSize: 16, color: color),
      ],
    );
  }

  Widget _buildRoleBadges() {
    return Row(
      children: [
        if (member.isAdmin) _buildSmallIcon(Icons.admin_panel_settings, AppColors.secondaryScale[400]!),
        if (member.isSecurity) _buildSmallIcon(Icons.shield_outlined, AppColors.secondaryScale[400]!),
        if (member.isResident) _buildSmallIcon(Icons.home_work_outlined, AppColors.secondaryScale[400]!),
      ],
    );
  }

  Widget _buildSmallIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
