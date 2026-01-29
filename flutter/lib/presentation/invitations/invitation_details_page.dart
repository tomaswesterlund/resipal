import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/access_log_entity.dart';

class InvitationDetailsPage extends StatelessWidget {
  final InvitationEntity invitation;
  const InvitationDetailsPage(this.invitation, {super.key});

  String _formatDate(DateTime date) =>
      DateFormat('dd MMM yyyy, hh:mm a').format(date);

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

            // Details Card
            SectionHeaderText(text: 'INFORMACIÓN GENERAL'),
            DefaultCard(
              child: Column(
                children: [
                  DetailTile(
                    icon: Icons.event_available_rounded,
                    label: 'Fecha de pago',
                    value: invitation.fromDate.toShortDate()
                  ),
                ],
              ),
            ),
            _buildInfoCard(),
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

            // Share Button
            _buildShareButton(),
            const SizedBox(height: 20),
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

  Widget _buildInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _buildDetailTile(
            icon: Icons.home_work_outlined,
            label: 'Propiedad',
            value: invitation.property.name,
          ),
          const Divider(height: 1),
          _buildDetailTile(
            icon: Icons.calendar_today_outlined,
            label: 'Válido desde',
            value: _formatDate(invitation.fromDate),
          ),
          const Divider(height: 1),
          _buildDetailTile(
            icon: Icons.history_toggle_off_outlined,
            label: 'Válido hasta',
            value: _formatDate(invitation.toDate),
          ),
          const Divider(height: 1),
          _buildDetailTile(
            icon: Icons.pin_outlined,
            label: 'Uso de Entradas',
            value:
                '${invitation.usageCount} / ${invitation.maxEntries} (${invitation.remainingEntries} restantes)',
          ),
        ],
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

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sortedLogs.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final log = sortedLogs[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: log.isEntry
                  ? Colors.blue[50]
                  : Colors.orange[50],
              child: Icon(
                log.isEntry ? Icons.login_rounded : Icons.logout_rounded,
                color: log.isEntry ? Colors.blue[800] : Colors.orange[800],
                size: 20,
              ),
            ),
            title: Text(
              log.isEntry ? 'Entrada Registrada' : 'Salida Registrada',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Text(_formatDate(log.timestamp)),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 16,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShareButton() {
    final bool active = invitation.canEnter;

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        // Disable button if invitation is not active
        onPressed: active
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
