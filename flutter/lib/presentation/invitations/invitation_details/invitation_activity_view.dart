import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';

class InvitationActivityView extends StatelessWidget {
  final InvitationEntity invitation;
  const InvitationActivityView(this.invitation, {super.key});

  @override
  Widget build(BuildContext context) {
    if (invitation.logs.isEmpty) {
      return Center(child: BodyText.medium('Sin actividad registrada.'));
    }

    return DefaultCard(
      padding: 0,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: invitation.logs.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final log = invitation.logs[index];

          return DetailTile(
            icon: log.isEntry ? Icons.login_rounded : Icons.logout_rounded,
            label: log.isEntry ? 'Entrada Registrada' : 'Salida Registrada',
            color: log.isEntry ? AppColors.success : AppColors.warning,
            value: log.timestamp.toShortDate(),
          );
        },
      ),
    );
  }
}
