import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';
import 'package:intl/intl.dart';

class InvitationDetailsPage extends StatefulWidget {
  final InvitationEntity invitation;
  const InvitationDetailsPage({required this.invitation, super.key});

  @override
  State<InvitationDetailsPage> createState() => _InvitationDetailsPageState();
}

class _InvitationDetailsPageState extends State<InvitationDetailsPage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const MyAppBar(title: 'Detalle de Invitación'),
      body: _currentPageIndex == 0 ? _InvitationOverview(widget.invitation) : _InvitationLogs(widget.invitation),
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
  const _InvitationOverview(this.invitation);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final String range =
        "${DateFormat('dd MMM').format(invitation.fromDate)} al ${DateFormat('dd MMM').format(invitation.toDate)}";

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Área del QR
          DefaultCard(
            child: Column(
              children: [
                const SizedBox(height: 16),
                HeaderText.five('PASE DE ACCESO', color: colorScheme.primary),
                const SizedBox(height: 24),
                // Aquí integrarías tu widget de generación de QR con invitation.qrCodeToken
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PrettyQrView.data(
                    data: invitation.qrCodeToken,
                    decoration: const PrettyQrDecoration(
                      shape: PrettyQrShape.custom(
                        PrettyQrSquaresSymbol(),
                        finderPattern: PrettyQrSmoothSymbol(),
                        // alignmentPatterns: PrettyQrDotsSymbol(),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   width: 200,
                //   height: 200,
                //   decoration: BoxDecoration(color: colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(12)),
                //   child: Icon(
                //     Icons.qr_code_rounded,
                //     size: 140,
                //     color: invitation.canEnter ? Colors.black : colorScheme.error.withOpacity(0.5),
                //   ),
                // ),
                const SizedBox(height: 24),
                StatusBadge(
                  label: invitation.canEnter ? 'INVITACIÓN ACTIVA' : 'INVITACIÓN INVÁLIDA',
                  color: invitation.canEnter ? Colors.green : colorScheme.error,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          const SizedBox(height: 24),
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
                  value: '${invitation.usageCount} de ${invitation.maxEntries} utilizados',
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
      return Center(child: BodyText.medium('No se registran entradas con este pase aún.'));
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
