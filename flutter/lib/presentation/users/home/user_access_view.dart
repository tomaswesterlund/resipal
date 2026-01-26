import 'package:flutter/material.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/access/invitation_list_view.dart';

class UserAccessView extends StatelessWidget {
  final UserEntity user;

  const UserAccessView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GreenBoxContainer(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: HeaderText.two('Accesos', color: Colors.white),
                ),
              ),
            ),
          ),
        Text('Create QR'),
        HeaderText.three('Invitaciones activas'),
        InvitationListView(user.activeInvitations),
        Text('Frecuentes'),
        Text('Historial'),
      ],
    );
  }
}
