import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/community/community_directory_entity.dart';
import 'package:resipal_core/presentation/memberships/member_card.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';

class AdminMembersView extends StatelessWidget {
  final CommunityDirectoryEntity directory;
  const AdminMembersView(this.directory, {super.key});

  @override
  Widget build(BuildContext context) {
    if (directory.members.isEmpty) {
      return Center(
        child: BodyText.medium(
          'No se encontraron miembros registrados.',
          color: Colors.grey.shade600,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: directory.members.length,
          itemBuilder: (ctx, index) {
            final member = directory.members[index];
            return MembershipCard(member);
          },
        ),
      ),
    );
  }
}
