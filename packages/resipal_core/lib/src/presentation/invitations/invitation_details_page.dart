import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/enums/invitation_status.dart';
import 'package:wester_kit/lib.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class InvitationDetailsPage extends StatefulWidget {
  final InvitationEntity invitation;
  const InvitationDetailsPage({required this.invitation, super.key});

  @override
  State<InvitationDetailsPage> createState() => _InvitationDetailsPageState();
}

class _InvitationDetailsPageState extends State<InvitationDetailsPage> {
  int _currentPageIndex = 0;
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _shareInvitation() async {
    final image = await _screenshotController.capture();

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/invitacion_${widget.invitation.visitor.name}.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles([
        XFile(imagePath.path),
      ], text: 'Pase de acceso para ${widget.invitation.visitor.name} en ${widget.invitation.property.name}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: MyAppBar(
        title: 'Detalle de Invitación',
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: _shareInvitation,
            tooltip: 'Compartir invitación',
          ),
        ],
      ),
      body: _currentPageIndex == 0
          ? _InvitationOverview(
              invitation: widget.invitation,
              screenshotController: _screenshotController,
              onSharePressed: _shareInvitation,
            )
          : _InvitationLogs(widget.invitation),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: FloatingNavBar(
          currentIndex: _currentPageIndex,
          onChanged: (index) => setState(() => _currentPageIndex = index),
          items: [
            FloatingNavBarItem(icon: Icons.qr_code_2_rounded, label: 'Pase QR'),
            FloatingNavBarItem(
              icon: Icons.format_list_bulleted_rounded,
              label: 'Historial',
              warningBadgeCount: widget.invitation.usageCount,
            ),
          ],
        ),
      ),
    );
  }
}

// --- VIEW 1: QR & GENERAL INFO ---
class _InvitationOverview extends StatelessWidget {
  final InvitationEntity invitation;
  final VoidCallback onSharePressed;
  final ScreenshotController screenshotController;

  const _InvitationOverview({
    required this.invitation,
    required this.screenshotController,
    required this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final status = invitation.status;

    final String range =
        "${DateFormat('dd MMM').format(invitation.fromDate)} al ${DateFormat('dd MMM').format(invitation.toDate)}";

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Envolvemos la tarjeta en Screenshot para capturar el QR y estatus
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: colorScheme.surface, // Fondo sólido para la captura
              child: DefaultCard(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    HeaderText.five('PASE DE ACCESO', color: status.color(colorScheme)),
                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Opacity(
                        opacity: status == InvitationStatus.expired ? 0.3 : 1.0,
                        child: PrettyQrView.data(
                          data: invitation.qrCodeToken,
                          decoration: const PrettyQrDecoration(
                            shape: PrettyQrShape.custom(
                              const PrettyQrSquaresSymbol(),
                              finderPattern: const PrettyQrSmoothSymbol(),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    StatusBadge(label: 'INVITACIÓN ${status.display.toUpperCase()}', color: status.color(colorScheme)),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(label: 'COMPARTIR', icon: Icons.share, onPressed: onSharePressed),
              ),
            ],
          ),

          const SizedBox(height: 36),
          const SectionHeaderText(text: 'DETALLES DEL VISITANTE'),
          DefaultCard(
            child: Column(
              children: [
                DetailTile(icon: Icons.person_outline, label: 'Nombre', value: invitation.visitor.name),
                Divider(height: 1, color: colorScheme.outlineVariant),
                DetailTile(icon: Icons.home_outlined, label: 'Propiedad destino', value: invitation.property.name),
                Divider(height: 1, color: colorScheme.outlineVariant),
                DetailTile(icon: Icons.date_range_rounded, label: 'Vigencia', value: range),
                Divider(height: 1, color: colorScheme.outlineVariant),
                DetailTile(
                  icon: Icons.repeat_rounded,
                  label: 'Límite de usos',
                  value: invitation.maxEntries == null
                      ? 'Ilimitada (${invitation.usageCount} utilizados)'
                      : '${invitation.usageCount} de ${invitation.maxEntries} utilizados',
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

// --- VIEW 2: ACCESS LOGS ---
class _InvitationLogs extends StatelessWidget {
  final InvitationEntity invitation;
  const _InvitationLogs(this.invitation);

  @override
  Widget build(BuildContext context) {
    final logs = invitation.logs;

    if (logs.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: BodyText.medium('No se registran entradas con este pase aún.', textAlign: TextAlign.center),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: logs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final log = logs[index];
        final String logTime = DateFormat('dd MMM, HH:mm').format(log.createdAt);

        return DefaultCard(
          child: Row(
            children: [
              Icon(
                log.isEntry ? Icons.login_rounded : Icons.logout_rounded,
                color: log.isEntry ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText.medium(log.isEntry ? 'Entrada registrada' : 'Salida registrada'),
                    OverlineText(logTime),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
