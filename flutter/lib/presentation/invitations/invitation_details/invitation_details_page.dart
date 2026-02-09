import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/floating_nav_bar.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/access_log_entity.dart';
import 'package:resipal/presentation/invitations/invitation_details/invitation_activity_view.dart';
import 'package:resipal/presentation/invitations/invitation_details/invitation_information_view.dart';
import 'package:resipal/presentation/invitations/invitation_details/invitation_qr_view.dart';

class InvitationDetailsPage extends StatefulWidget {
  final InvitationEntity invitation;
  const InvitationDetailsPage(this.invitation, {super.key});

  @override
  State<InvitationDetailsPage> createState() => _InvitationDetailsPageState();
}

class _InvitationDetailsPageState extends State<InvitationDetailsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MyAppBar(title: 'Detalles de Invitación'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: IndexedStack(index: _currentIndex, children: [
          InvitationQrView(widget.invitation),
          InvitationInformationView(widget.invitation),
          InvitationActivityView(widget.invitation),
        ],
      ),
      ),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: _currentIndex,
        onChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          FloatingNavBarItem(icon: Icons.qr_code, label: 'QR'),
          FloatingNavBarItem(icon: Icons.info, label: 'Información'),
          FloatingNavBarItem(icon: Icons.history, label: 'Actividad'),
        ],
      ),
    );
  }
}
