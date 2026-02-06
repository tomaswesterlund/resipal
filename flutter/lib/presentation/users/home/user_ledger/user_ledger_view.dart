import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/cards/shimmer_card.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/unknown_state_view.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/ledger/movement_list_view.dart';
import 'package:resipal/presentation/users/home/user_ledger/user_ledger_cubit.dart';
import 'package:resipal/presentation/users/home/user_ledger/user_ledger_state.dart';

class UserLedgerView extends StatelessWidget {
  final UserEntity user;
  const UserLedgerView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreenBoxContainer(
              child: SafeArea(
                child: Column(children: [HeaderText.one('Movimientos', color: Colors.white)]),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText.four('Mis últimos movimientos'),
                  const SizedBox(height: 12),
                  BlocProvider(
                    create: (ctx) => UserLedgerCubit()..intialize(user.id),
                    child: BlocBuilder<UserLedgerCubit, UserLedgerState>(
                      builder: (ctx, state) {
                        if (state is InitialState || state is LoadingState) {
                          return Column(children: [ShimmerCard(), ShimmerCard(), ShimmerCard()]);
                        }

                        if (state is ErrorState) {
                          return ErrorStateView();
                        }

                        if (state is LoadedState) {
                          return MovementListView(state.ledger.movements);
                        }

                        return UnknownStateView();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 148),
          ],
        ),
      ),
    );
  }
}
