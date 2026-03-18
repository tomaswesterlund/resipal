import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/enums/invitation_status.dart';
import 'package:resipal_core/src/presentation/invitations/invitation_details/invitation_details_cubit.dart';
import 'package:resipal_core/src/presentation/invitations/invitation_details/invitation_details_state.dart';
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

  Future<void> _shareInvitation(InvitationEntity invitation) async {
    final image = await _screenshotController.capture();

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/invitacion_${invitation.visitor.name}.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles([
        XFile(imagePath.path),
      ], text: 'Pase de acceso para ${invitation.visitor.name} en ${invitation.property.name}.');
    }
  }

  Widget _buildBody(InvitationEntity invitation) {
    switch (_currentPageIndex) {
      case 0:
        return _InvitationOverview(
          invitation: invitation,
          screenshotController: _screenshotController,
          onSharePressed: () => _shareInvitation(invitation),
        );
      case 1:
        return _Visitor(invitation);
      case 2:
        return _InvitationLogs(invitation);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider<InvitationDetailsCubit>(
      create: (context) => InvitationDetailsCubit()..initialize(widget.invitation),

      child: BlocBuilder<InvitationDetailsCubit, InvitationDetailsState>(
        builder: (context, state) {
          if (state is InvitationDetailsErrorState) {
            return ErrorView();
          }

          final invitation = (state is InvitationDetailsLoadedState) ? state.invitation : widget.invitation;

          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: MyAppBar(
              title: 'Detalle de Invitación',
              actions: [
                IconButton(
                  icon: const Icon(Icons.share_rounded),
                  onPressed: () => _shareInvitation(invitation),
                  tooltip: 'Compartir invitación',
                ),
              ],
            ),
            body: _buildBody(invitation),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: FloatingNavBar(
                currentIndex: _currentPageIndex,
                onChanged: (index) => setState(() => _currentPageIndex = index),
                items: [
                  FloatingNavBarItem(icon: Icons.qr_code_2_rounded, label: 'Pase QR'),
                  FloatingNavBarItem(icon: Icons.badge_outlined, label: 'Visitante'),
                  FloatingNavBarItem(
                    icon: Icons.format_list_bulleted_rounded,
                    label: 'Historial',
                    warningBadgeCount: invitation.logs.length,
                  ),
                ],
              ),
            ),
          );
        },
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

          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

// --- VIEW 2: Visitante ---
class _Visitor extends StatelessWidget {
  final InvitationEntity invitation;
  const _Visitor(this.invitation);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SectionHeaderText(text: 'IDENTIFICACIÓN'),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                height: 250,
                color: colorScheme.surfaceVariant,
                child: BucketImage(bucket: 'visitors', path: invitation.visitor.identificationPath),
              ),
            ),
            SizedBox(height: 48,),
            const SectionHeaderText(text: 'DETALLES DEL VISITANTE'),
            DefaultCard(
              child: Column(
                children: [
                  DetailTile(icon: Icons.person_outline, label: 'Nombre', value: invitation.visitor.name),
                  Divider(height: 1, color: colorScheme.outlineVariant),
                  DetailTile(icon: Icons.home_outlined, label: 'Propiedad destino', value: invitation.property.name),
                  Divider(height: 1, color: colorScheme.outlineVariant),
                  DetailTile(
                    icon: Icons.date_range_rounded,
                    label: 'Vigencia',
                    value: DateFormatters.toDateRange(invitation.fromDate, invitation.toDate),
                  ),
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
            SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }
}

// --- VIEW 3: ACCESS LOGS ---
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
          child: Column(
            children: [
              DetailTile(
                icon: log.direction == AccessLogDirection.entry ? Icons.login_rounded : Icons.logout_rounded,
                //iconColor: log.direction == AccessLogDirection.entry ? Colors.green : Colors.orange,
                label: 'Movimiento',
                value: log.direction == AccessLogDirection.entry ? 'Entrada registrada' : 'Salida registrada',
              ),
              // Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
              // DetailTile(icon: Icons.person_2_outlined, label: 'Visitante', value: log.visitor.name),
              Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
              DetailTile(icon: Icons.access_time_rounded, label: 'Fecha y hora', value: logTime),
            ],
          ),
        );
      },
    );
  }
}
