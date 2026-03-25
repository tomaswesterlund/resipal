import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/my_app_bar.dart';

class InvitationsPage extends StatelessWidget {
  final List<InvitationEntity> invitations;
  const InvitationsPage({required this.invitations, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Invitaciones'),
      body: InvitationListView(invitations),
    );
  }
}