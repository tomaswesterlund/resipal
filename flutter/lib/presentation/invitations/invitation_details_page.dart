import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/access_log_entity.dart';

class InvitationDetailsPage extends StatelessWidget {
  final InvitationEntity invitation;
  const InvitationDetailsPage(this.invitation, {super.key});

  @override
  Widget build(BuildContext context) {
    // Sort logs by newest first for the history view
    final sortedLogs = List<AccessLogEntity>.from(invitation.logs)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(title: 'Detalles de Invitación'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QR Code Card
            _buildQRCard(),
            const SizedBox(height: 20),

            // Share Button
            _buildShareButton(),
            const SizedBox(height: 30),

            // Details Card
            SectionHeaderText(text: 'INFORMACIÓN GENERAL'),
            DefaultCard(
              padding: 0,
              child: Column(
                children: [
                  DetailTile(
                    icon: Icons.home_work_outlined,
                    label: 'Propiedad',
                    value: invitation.property.name,
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.calendar_today_outlined,
                    label: 'Válido',
                    value: DateFormatters.toDateRange(
                      invitation.fromDate,
                      invitation.toDate,
                    ),
                  ),

                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.pin_outlined,
                    label: 'Uso de Entradas',
                    value:
                        '${invitation.usageCount} / ${invitation.maxEntries} (${invitation.remainingEntries} restantes)',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- Access History Section ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text(
                'HISTORIAL DE ACCESOS',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            _buildHistoryCard(sortedLogs),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCard() {
    final bool active = invitation.canEnter;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: Text(
                invitation.visitor.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: active ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                active ? 'ACTIVA' : 'INVÁLIDA / AGOTADA',
                style: TextStyle(
                  color: active ? Colors.green[700] : Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Opacity(
                opacity: active ? 1.0 : 0.3, // Visual cue for inactive QR
                child: QrImageView(
                  data: invitation.qrCodeToken,
                  version: QrVersions.auto,
                  size: 200.0,
                  gapless: false,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              active
                  ? 'Presenta este código en caseta'
                  : 'Este código ya no es válido',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(List<AccessLogEntity> sortedLogs) {
    if (sortedLogs.isEmpty) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              'Sin movimientos registrados',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return DefaultCard(
      padding: 0,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sortedLogs.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final log = sortedLogs[index];

          return DetailTile(
            icon: log.isEntry ? Icons.login_rounded : Icons.logout_rounded,
            label: log.isEntry ? 'Entrada Registrada' : 'Salida Registrada',
            color: log.isEntry ? AppColors.success : AppColors.warning,
            value: log.timestamp.toShortDate(),
          );
        },
      ),
    );
  }

  Widget _buildShareButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        // Disable button if invitation is not active
        onPressed: invitation.canEnter
            ? () {
                // TODO: Implement share logic
              }
            : null,
        icon: const Icon(Icons.share),
        label: const Text('COMPARTIR QR'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[800],
          disabledBackgroundColor: Colors.grey[300],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[800]),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}
