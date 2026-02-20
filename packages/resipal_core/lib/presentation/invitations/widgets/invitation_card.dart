import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_core/domain/entities/invitation_entity.dart';
import 'package:resipal_core/helpers/formatters/date_formatters.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';

class InvitationCard extends StatelessWidget {
  final InvitationEntity invitation;
  final VoidCallback onPressed;
  const InvitationCard(this.invitation, {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Determine State
    final bool isActive = invitation.canEnter;
    final bool isUpcoming = invitation.isUpcoming;

    // 2. Map colors and icons based on state
    Color statusColor;
    Color borderColor;
    IconData statusIcon;

    if (isActive) {
      statusColor = BaseAppColors.success;
      borderColor = BaseAppColors.successScale[200]!;
      statusIcon = Icons.check_circle_rounded;
    } else if (isUpcoming) {
      statusColor = BaseAppColors.warning;
      borderColor = BaseAppColors.warningScale[200]!;
      statusIcon = Icons.schedule_rounded; // Clock icon for upcoming
    } else {
      statusColor = BaseAppColors.danger;
      borderColor = BaseAppColors.dangerScale[200]!;
      statusIcon = Icons.history_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor, // Now using the specific scale color
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: BaseAppColors.auxiliarScale[900]!.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.qr_code_2_rounded,
                                  size: 20,
                                  color: BaseAppColors.secondaryScale[400],
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: HeaderText.five(
                                    invitation.visitor.name,
                                    color: BaseAppColors.auxiliarScale[900]!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Status Icon reflects state
                          Icon(statusIcon, color: statusColor, size: 18),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Propiedad: ${invitation.property.name}',
                        style: GoogleFonts.raleway(
                          color: BaseAppColors.auxiliarScale[500],
                          fontSize: 13,
                        ),
                      ),
                      Divider(
                        height: 24,
                        thickness: 1,
                        color: BaseAppColors.auxiliarScale[100],
                      ),

                      // Footer: Dates and Action
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isUpcoming ? 'Válida a partir de' : 'Fechas',
                                style: GoogleFonts.raleway(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: BaseAppColors.auxiliarScale[400],
                                ),
                              ),
                              Text(
                                DateFormatters.toDateRange(
                                  invitation.fromDate,
                                  invitation.toDate,
                                ),
                                style: GoogleFonts.raleway(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: BaseAppColors.auxiliarScale[800],
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: BaseAppColors.secondary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              textStyle: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            onPressed: onPressed,
                            child: const Row(
                              children: [
                                Text('Detalles'),
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
}
