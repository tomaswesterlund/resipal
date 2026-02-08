import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/invitations/create_invitation/create_invitation_page.dart';
import 'package:resipal/presentation/invitations/active_invitation_list/active_invitation_list_view.dart';
import 'package:resipal/presentation/visitors/create_visitor/create_visitor_page.dart';
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
                children: [HeaderText.one('Accesos', color: Colors.white)],
              ),
            ),
          ),


          Container(
            color: AppColors.background,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryCtaButton(
                    label: 'Crear invitación',
                    canSubmit: true,
                    onPressed: () => Go.to(CreateInvitationPage()),
                  ),
            
                  const SizedBox(height: 12.0),
            
                  PrimaryCtaButton(
                    label: 'Crear visitante',
                    canSubmit: true,
                    onPressed: () => Go.to(CreateVisitorPage()),
                  ),
            
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderText.four('Invitaciones activas'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Ver todas >',
                          style: GoogleFonts.raleway(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ActiveInvitationListView(userId: user.id),
                  SizedBox(height: 148),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
