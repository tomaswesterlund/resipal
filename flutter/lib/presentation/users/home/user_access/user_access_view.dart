import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';
import 'package:resipal/presentation/invitations/create_invitation/create_invitation_page.dart';
import 'package:resipal/presentation/invitations/invitation_list_view.dart';
import 'package:resipal/presentation/users/home/user_access/user_access_cubit.dart';
import 'package:resipal/presentation/users/home/user_access/user_access_state.dart';
import 'package:resipal/presentation/visitors/create_visitor/create_visitor_page.dart';
import 'package:resipal/presentation/visitors/visitor_list_view.dart';
import 'package:short_navigation/short_navigation.dart';

class UserAccessView extends StatelessWidget {
  final String userId;

  const UserAccessView({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserAccessCubit()..initialize(userId),
      child: BlocBuilder<UserAccessCubit, UserAccessState>(
        builder: (ctx, state) {
          if (state is InitialState || state is LoadingState) {
            return LoadingView();
          }

          if (state is LoadedState) {
            return _Loaded(state.activeInvitations, state.visitors);
          }

          if (state is ErrorState) {
            return ErrorStateView();
          }

          return UnknownStateView();
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  final List<InvitationEntity> activeInvitations;
  final List<VisitorEntity> visitors;
  const _Loaded(this.activeInvitations, this.visitors, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GreenBoxContainer(
            child: SafeArea(
              child: Column(children: [HeaderText.one('Accesos', color: Colors.white)]),
            ),
          ),
          Container(
            color: AppColors.background,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  InvitationListView(activeInvitations),
                  const SizedBox(height: 24),
                  PrimaryCtaButton(
                    label: 'Crear nueva invitación',
                    canSubmit: true,
                    onPressed: () => Go.to(CreateInvitationPage()),
                  ),

                  const SizedBox(height: 48),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeaderText.four('Visitantes registrados'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Ver todos >',
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
                  VisitorListView(visitors),
                  const SizedBox(height: 24),
                  PrimaryCtaButton(
                    icon: Icons.person,
                    label: 'Registrar visitante',
                    canSubmit: true,
                    onPressed: () => Go.to(CreateVisitorPage()),
                  ),
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
