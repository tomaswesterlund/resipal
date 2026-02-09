import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';

class InvitationQrView extends StatelessWidget {
  final InvitationEntity invitation;
  const InvitationQrView(this.invitation, {super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the state and styling
    final bool active = invitation.canEnter;
    final bool upcoming = invitation.isUpcoming;

    String statusText;
    Color? bgColor;
    Color? textColor;
    String footerText;

    if (active) {
      statusText = 'ACTIVA';
      bgColor = AppColors.successScale[50];
      textColor = AppColors.successScale[700];
      // Added property context here as well for clarity
      footerText = 'Válida para visitar la propiedad "${invitation.property.name}" entre las fechas ${DateFormatters.toDateRange(invitation.fromDate, invitation.toDate)}';
    } else if (upcoming) {
      statusText = 'PRÓXIMA';
      bgColor = AppColors.warningScale[50];
      textColor = AppColors.warningScale[700];
      footerText =
          'Válida para visitar la propiedad "${invitation.property.name}" entre las fechas ${DateFormatters.toDateRange(invitation.fromDate, invitation.toDate)}';
    } else {
      statusText = 'YA NO ACTIVA';
      bgColor = AppColors.dangerScale[50];
      textColor = AppColors.dangerScale[700];
      footerText = 'Este código expiró el ${invitation.toDate.day}/${invitation.toDate.month}';
    }

    return Column(
      children: [
        DefaultCard(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    invitation.visitor.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    statusText,
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Opacity(
                    // QR is dimmed if not active (either expired or upcoming)
                    opacity: active ? 1.0 : 0.3,
                    child: QrImageView(
                      data: invitation.qrCodeToken,
                      version: QrVersions.auto,
                      size: 200.0,
                      gapless: false,
                      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  footerText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: PrimaryCtaButton(label: 'COMPARTIR QR', onPressed: () {}),
        ),
      ],
    );
  }
}
