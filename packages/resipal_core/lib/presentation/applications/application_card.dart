import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_core/domain/entities/application_entity.dart';
import 'package:resipal_core/domain/enums/community_application_status.dart';
import 'package:resipal_core/helpers/formatters/date_formatters.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';

class ApplicationCard extends StatelessWidget {
  final ApplicationEntity application;

  const ApplicationCard(this.application, {super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Logic & Color mapping (Architecture mirroring PaymentColors)
    final (statusColor, statusIcon) = _getStatusData();
    final bool isPending = application.status == ApplicationStatus.pendingReview;

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
              // 2. Status Indicator Pillar
              Container(width: 6, color: statusColor),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 3. Header: Primary Data & Status Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Solicitante',
                                style: GoogleFonts.raleway(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: BaseAppColors.auxiliarScale[400],
                                ),
                              ),
                              HeaderText.five(
                                application.user.name,
                                color: isPending 
                                    ? BaseAppColors.auxiliarScale[800]! 
                                    : BaseAppColors.secondary,
                              ),
                            ],
                          ),
                          Icon(statusIcon, color: statusColor, size: 20),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // 4. Content Body (Message)
                      Text(
                        application.message ?? 'Sin mensaje adjunto',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.raleway(
                          color: BaseAppColors.auxiliarScale[500],
                          fontSize: 13,
                          fontStyle: application.message == null 
                              ? FontStyle.italic 
                              : FontStyle.normal,
                        ),
                      ),

                      // 5. Divider (Architecture mirroring PaymentCard)
                      const Divider(
                        height: 12, // Consistent with your PropertyCard logic
                        thickness: 1,
                        color: Color(0xFFF4F5F4),
                      ),

                      // 6. Footer: Status Badge, Meta Data & Action
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  application.status.name.toUpperCase(),
                                  style: GoogleFonts.raleway(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Enviado: ${application.createdAt.toShortDate()}',
                                style: GoogleFonts.raleway(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: BaseAppColors.auxiliarScale[600],
                                ),
                              ),
                            ],
                          ),

                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: BaseAppColors.secondary,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              textStyle: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            onPressed: () {
                              // Go.to(ApplicationDetailsPage(applicationId: application.id));
                            },
                            child: const Row(
                              children: [
                                Text('Revisar'),
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

  // Visual mapping architecture
  (Color, IconData) _getStatusData() {
    return switch (application.status) {
      ApplicationStatus.approved => (BaseAppColors.success, Icons.check_circle),
      ApplicationStatus.pendingReview => (BaseAppColors.warning, Icons.schedule_rounded),
      ApplicationStatus.rejected => (BaseAppColors.danger, Icons.cancel_outlined),
      ApplicationStatus.revoked => (BaseAppColors.auxiliarScale[400]!, Icons.history_rounded),
    };
  }
}