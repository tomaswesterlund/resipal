import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/presentation/invitations/invitation_details_page.dart';
import 'package:short_navigation/short_navigation.dart';

class InvitationCard extends StatelessWidget {
  final InvitationEntity invitation;
  const InvitationCard(this.invitation, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool isActive = invitation.canEnter;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          // Subtle border tint based on status
          color: isActive
              ? AppColors.success.withOpacity(0.2)
              : AppColors.danger.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Status Indicator Side Bar
              Container(
                width: 6,
                color: isActive ? AppColors.success : AppColors.danger,
              ),

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
                          // Visitor Icon & Name
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.qr_code_2_rounded,
                                  size: 20,
                                  color: AppColors.secondaryScale[400],
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: HeaderText.five(
                                    invitation.visitor.name,
                                    color: AppColors.auxiliarScale[900]!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Status Icon
                          Icon(
                            isActive
                                ? Icons.check_circle
                                : Icons.history_rounded,
                            color: isActive
                                ? AppColors.success
                                : AppColors.danger,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Propiedad: ${invitation.property.name}',
                        style: GoogleFonts.raleway(
                          color: AppColors.auxiliarScale[500],
                          fontSize: 13,
                        ),
                      ),
                      Divider(
                        height: 24,
                        thickness: 1,
                        color: AppColors.auxiliarScale[100],
                      ),

                      // Footer: Dates and Action
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fechas',
                                style: GoogleFonts.raleway(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.auxiliarScale[400],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    DateFormatters.toDateRange(
                                      invitation.fromDate,
                                      invitation.toDate,
                                    ),
                                    style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.auxiliarScale[800],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.secondary,
                              textStyle: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            onPressed: () =>
                                Go.to(InvitationDetailsPage(invitation)),
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
