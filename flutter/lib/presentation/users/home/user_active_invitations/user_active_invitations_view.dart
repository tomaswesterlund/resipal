import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/cards/shimmer_card.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/invitations/invitation_list_view.dart';
import 'package:resipal/presentation/users/home/user_active_invitations/user_active_invitations_cubit.dart';
import 'package:resipal/presentation/users/home/user_active_invitations/user_active_invitations_state.dart';

class UserActiveInvitationsView extends StatelessWidget {
  final UserEntity user;
  const UserActiveInvitationsView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UserActiveInvitationsCubit()..intialize(user.id),
      child:
          BlocBuilder<UserActiveInvitationsCubit, UserActiveInvitationsState>(
            builder: (ctx, state) {
              if (state.isError) {
                return ErrorStateView(
                  errorMessage: state.errorMessage,
                  exception: state.exception,
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText.four('Mis invitaciones activas'),
                  const SizedBox(height: 12),
                  if (state.isFetching) ...[
                    ShimmerCard(),
                    ShimmerCard(),
                    ShimmerCard(),
                  ] else
                    InvitationListView(state.invitations),
                  SizedBox(height: 148),
                ],
              );
            },
          ),
    );
  }
}
