import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/presentation/invitations/invitation_card.dart';
import 'package:resipal/presentation/invitations/active_invitation_list/invitation_list_cubit.dart';

class ActiveInvitationListView extends StatelessWidget {
  final String userId;

  const ActiveInvitationListView({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActiveInvitationListCubit>(
      create: (ctx) => ActiveInvitationListCubit()..initialize(userId),
      child: BlocBuilder<ActiveInvitationListCubit, ActiveInvitationListState>(
        builder: (ctx, state) {
          if (state is InitialState || state is LoadingState) {
            return const LoadingView();
          }

          if (state is LoadedState) {
            if (state.invitations.isEmpty) {
              return Text('No invitations found ...');
            }
            return _Loaded(invitations: state.invitations);
          }

          if (state is ErrorState) {
            return ErrorStateView();
          }

          return const UnknownStateView();
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  final List<InvitationEntity> invitations;
  const _Loaded({required this.invitations});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: invitations.length,
      itemBuilder: (ctx, index) {
        final invitation = invitations[index];
        return InvitationCard(invitation);
      },
    );
  }
}
