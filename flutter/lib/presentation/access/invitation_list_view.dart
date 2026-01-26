import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/presentation/access/invitation_details_page.dart';
import 'package:short_navigation/short_navigation.dart';

class InvitationListView extends StatelessWidget {
  final List<InvitationEntity> invitations;
  const InvitationListView(this.invitations, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: invitations.length,
      itemBuilder: (ctx, index) {
        final invitation = invitations[index];
        return GestureDetector(
          onTap: () => Go.to(InvitationDetailsPage(invitation)),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.directions_car, size: 40),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText.five(invitation.visitor.name),
                      HeaderText.six(
                        'Car',
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(invitation.property.name),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        );

        //return ListTile(title: Text('TEST'));
      },
    );
  }
}
