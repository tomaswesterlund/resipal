import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/containers/green_box_container.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/views/error_state_view.dart';
import 'package:resipal/core/ui/views/loading_view.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/presentation/movements/widgets/movement_list_view.dart';
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
          GreenBoxContainer(
            child: Column(
              children: [
                const SizedBox(height: 24.0),
                HeaderText.one('Saldo total', color: Colors.white),
                AmountText.fromCents(
                  user.totalBalanceInCents,
                  color: Colors.white,
                ),

                // --- Payment in Review Logic ---
                if (user.pendingPaymentAmountInCents > 0) ...[
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.history_toggle_off,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        BodyText.tiny(
                          'Pagos en revisión: ',
                          color: Colors.white,
                        ),
                        AmountText.fromCents(
                          user.pendingPaymentAmountInCents,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        const SizedBox(width: 4),
                        // --- The Help Button ---
                        GestureDetector(
                          onTap: () => _showReviewExplanation(context),
                          child: Icon(
                            Icons.help_outline_rounded,
                            color: Colors.white.withOpacity(0.7),
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 24.0),
                PrimaryCtaButton(
                  label: 'Registrar pago',
                  canSubmit: true,
                  onPressed: () => Go.to(const RegisterPaymentPage()),
                ),
              ],
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text('PROPERTY SELECTOR'),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: HeaderText.three('Mis movimientos'),
          ),
          MovementListView(sortedMovements),
        ],
      ),
    );
  }

  void _showReviewExplanation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: HeaderText.four('Pagos en revisión'),
        content: BodyText.small(
          'Este monto corresponde a los comprobantes que has subido pero que aún no han sido validados por administración.\n\nUna vez verificados, se aplicarán automáticamente a tu saldo total.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ENTENDIDO'),
          ),
        ],
      ),
    );
  }
}
