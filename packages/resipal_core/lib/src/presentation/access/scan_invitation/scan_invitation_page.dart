import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/enums/invitation_status.dart';
import 'package:resipal_core/src/presentation/access/access_denied_page.dart';
import 'package:resipal_core/src/presentation/access/scan_invitation/scan_invitation_cubit.dart';
import 'package:resipal_core/src/presentation/access/scan_invitation/scan_invitation_state.dart';
import 'package:resipal_core/src/presentation/access/validate_id_page.dart';
import 'package:resipal_core/src/presentation/qr/qr_scanner_view.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/ui/buttons/secondary_button.dart';

class ScanInvitationPage extends StatelessWidget {
  const ScanInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ScanInvitationCubit(),
        child: BlocConsumer<ScanInvitationCubit, ScanInvitationState>(
          listener: (context, state) {
            // Only show "Unknown Code" if the state specifically confirms it's invalid
            if (state is ScanInvitationQrCodeNotValidState) {
              Go.to(const AccessDeniedPage(title: 'Código Desconocido', reason: 'El QR no pertenece a este sistema'));
            }

            if (state is ScanInvitationQrCodeValidState) {
              final invitation = state.invitation;

              switch (invitation.status) {
                case InvitationStatus.active:
                  Go.to(ValidateIdPage(invitation: invitation));
                  break;
                case InvitationStatus.expired:
                  Go.to(AccessDeniedPage(title: invitation.visitor.name, reason: 'Pase Expirado'));
                  break;
                case InvitationStatus.upcoming:
                  Go.to(AccessDeniedPage(title: invitation.visitor.name, reason: 'Aún no es válido'));
                  break;
                case InvitationStatus.limitReached:
                  Go.to(AccessDeniedPage(title: invitation.visitor.name, reason: 'Límite de usos alcanzado'));
                  break;
              }
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // 1. The Scanner View
                QrScannerView(
                  onQrCodeDetected: (qrCodeToken) => context.read<ScanInvitationCubit>().onQrCodeScanned(qrCodeToken),
                ),

                // 2. The Cancel Button Overlay
                Positioned(
                  bottom: 40,
                  left: 32,
                  right: 32,
                  child: SecondaryButton(
                    label: 'CANCELAR / REGRESAR',
                    onPressed: () => Navigator.popUntil(Go.context, (route) => route.isFirst),
                    borderColor: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
