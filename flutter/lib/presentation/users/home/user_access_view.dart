import 'package:flutter/material.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/invitations/create_invitation/create_invitation_page.dart';
import 'package:resipal/presentation/invitations/invitation_list/invitation_list_view.dart';
import 'package:short_navigation/short_navigation.dart';

class UserAccessView extends StatelessWidget {
  final UserEntity user;

  const UserAccessView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GreenBoxContainer(
            child: SafeArea(
              child: Column(
                children: [
                  HeaderText.one('Accesos', color: Colors.white),
                  const SizedBox(height: 24.0),
                  PrimaryCtaButton(
                    label: 'Crear invitación',
                    canSubmit: true,
                    onPressed: () => Go.to(CreateInvitationPage()),
                  ),
                ],
              ),
            ),
          ),
      
          SizedBox(height: 12),
          HeaderText.three('Invitaciones activas'),
          InvitationListView(userId: user.id,),
          Text('Frecuentes'),
          Text('Historial'),
        ],
      ),
    );
  }
}
