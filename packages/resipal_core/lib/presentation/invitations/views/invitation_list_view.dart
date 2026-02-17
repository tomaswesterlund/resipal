import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/invitation_entity.dart';
import 'package:resipal_core/presentation/invitations/views/no_invitations_found_view.dart';

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
        return Text('NOT IMPLENENTED!');
        // return InvitationCard(invitation);
      },
    );
  }
}