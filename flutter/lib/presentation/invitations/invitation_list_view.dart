import 'package:flutter/material.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/presentation/invitations/invitation_card.dart';
import 'package:resipal/presentation/invitations/no_invitations_found_view.dart';

class InvitationListView extends StatelessWidget {
  final List<InvitationEntity> invitations;
  const InvitationListView(this.invitations, {super.key});

  @override
  Widget build(BuildContext context) {
    if (invitations.isEmpty) return NoInvitationsFoundView();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: invitations.length,
      itemBuilder: (ctx, index) {
        final invitation = invitations[index];
        return InvitationCard(invitation);
      },
    );
  }
}