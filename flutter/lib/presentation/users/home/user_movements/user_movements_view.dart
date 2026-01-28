import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/maintenance/overdue_maintenance_info_row.dart';
import 'package:resipal/presentation/movements/widgets/movement_list_view.dart';
import 'package:resipal/presentation/payments/pending_payments_info_row.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_page.dart';
import 'package:resipal/presentation/users/home/user_movements/user_movements_cubit.dart';
import 'package:short_navigation/short_navigation.dart';

class UserMovementsView extends StatelessWidget {
  final UserEntity user;
  const UserMovementsView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Initialize the cubit and start watching movements immediately
      create: (context) => UserMovementsCubit()..initialize(user.id),
      child: BlocBuilder<UserMovementsCubit, UserMovementsState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return _Loaded(user: user, movements: state.movements);
          }

          if (state is LoadingState) {
            return const LoadingView(text: 'Cargando movimientos...');
          }

          if (state is ErrorState) {
            return ErrorStateView(
              errorMessage: state.errorMessage,
              exception: state.exception,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  final UserEntity user; // Pass the whole user to access getters
  final List<MovementEntity> movements;

  const _Loaded({required this.user, required this.movements, super.key});

  @override
  Widget build(BuildContext context) {
    final sortedMovements = [...movements]
      ..sort((a, b) => b.date.compareTo(a.date));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: HeaderText.three('Mis movimientos'),
          ),
          MovementListView(sortedMovements),
        ],
      ),
    );
  }
}
