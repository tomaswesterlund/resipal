import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/presentation/invitations/views/invitation_list_view.dart';
import 'package:resipal_core/presentation/shared/cards/shimmer_card.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';
import 'package:resipal_core/presentation/shared/views/error_view.dart';
import 'package:resipal_core/presentation/shared/views/unknown_state_view.dart';
import 'package:resipal_user/presentation/home/user_active_invitations/user_active_invitations_cubit.dart';
import 'package:resipal_user/presentation/home/user_active_invitations/user_active_invitations_state.dart';

class UserActiveInvitationsView extends StatelessWidget {
  final UserEntity user;
  const UserActiveInvitationsView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HeaderText.four('Mis invitaciones activas'),
            Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                'Ver todas >',
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: BaseAppColors.secondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BlocProvider(
          create: (ctx) => UserActiveInvitationsCubit()..intialize(user.id),
          child:
              BlocBuilder<
                UserActiveInvitationsCubit,
                UserActiveInvitationsState
              >(
                builder: (ctx, state) {
                  if (state is InitialState || state is LoadingState) {
                    return Column(
                      children: const [
                        ShimmerCard(),
                        ShimmerCard(),
                        ShimmerCard(),
                      ],
                    );
                  }

                  if (state is ErrorState) {
                    return const ErrorView();
                  }

                  if (state is LoadedState) {
                    return InvitationListView(state.invitations);
                  }

                  return const UnknownStateView();
                },
              ),
        ),
        const SizedBox(height: 148),
      ],
    );
  }
}
