import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class MaintenanceFeeDetailsPage extends StatelessWidget {
  final MaintenanceFeeEntity fee;
  const MaintenanceFeeDetailsPage({required this.fee, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusColor = fee.status.color(colorScheme);

    return BlocProvider(
      create: (ctx) => MaintenanceFeeDetailsCubit()..initialize(fee),
      child: BlocBuilder<MaintenanceFeeDetailsCubit, MaintenanceFeeDetailsState>(
        builder: (context, state) {
          final currentFee = (state is MaintenanceFeeDetailsLoadedState) ? state.fee : fee;

          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: MyAppBar(title: 'Detalle de Cuota'),
            body: _buildStateWidget(context, state, currentFee),
          );
        },
      ),
    );
  }

  Widget _buildStateWidget(BuildContext context, MaintenanceFeeDetailsState state, MaintenanceFeeEntity fee) {
    if (state is MaintenanceFeeDetailsInitialState || state is MaintenanceFeeDetailsLoadingState) {
      return const _FeeDetailsShimmer();
    }
    if (state is MaintenanceFeeDetailsLoadedState) {
      return _buildBody(context, state.fee, state.insufficientBalance);
    }
    if (state is MaintenanceFeeDetailsErrorState) {
      return const ErrorView();
    }
    return const UnknownStateView();
  }

  Widget _buildBody(BuildContext context, MaintenanceFeeEntity fee, bool insufficientBalance) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FeeHeaderCard(fee: fee),

          // Payment Action Section
          if (!fee.isPaid) ...[
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Pagar cuota',
              // Button is read-only (null callback) if balance is insufficient
              onPressed: insufficientBalance
                  ? null
                  : () => context.read<MaintenanceFeeDetailsCubit>().payMaintenanceFee(fee),
            ),
            if (insufficientBalance) ...[
              const SizedBox(height: 8),
              BodyText.small(
                'Saldo insuficiente para realizar el pago.',
                color: Colors.red,
                textAlign: TextAlign.center,
              ),
            ],
          ],

          const SizedBox(height: 24),
          const SectionHeaderText(text: 'PERÍODO Y VENCIMIENTO'),
          DefaultCard(
            child: Column(
              children: [
                DetailTile(
                  icon: Icons.date_range_outlined,
                  label: 'Periodo',
                  value: '${fee.fromDate.toShortDate()} - ${fee.toDate.toShortDate()}',
                ),
                Divider(height: 1, color: Colors.grey.withOpacity(0.1)),
                DetailTile(icon: Icons.event_available, label: 'Fecha Límite de Pago', value: fee.dueDate.toShortDate()),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeaderText(text: 'INFORMACIÓN ADICIONAL'),
          DefaultCard(
            child: Column(
              children: [
                DetailTile(icon: Icons.description_outlined, label: 'Contrato', value: fee.contract.name),
                if (fee.note != null && fee.note!.isNotEmpty) ...[
                  Divider(height: 1, color: Colors.grey.withOpacity(0.1)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyText.small('Nota:', color: Colors.grey),
                        const SizedBox(height: 4),
                        BodyText.medium(fee.note!),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Paid Status Section
          if (fee.isPaid) ...[
            const SizedBox(height: 24),
            SuccessCard(
              child: DetailTile(
                icon: Icons.check_circle_outline,
                label: 'Pagado el',
                value: fee.paymentDate!.toShortDate(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FeeHeaderCard extends StatelessWidget {
  final MaintenanceFeeEntity fee;
  const _FeeHeaderCard({required this.fee});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultCard(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            StatusBadge(color: fee.status.color(colorScheme), label: fee.status.display),
            const SizedBox(height: 16),
            AmountText(amountInCents: fee.amountInCents, color: fee.status.color(colorScheme)),
            BodyText.small('Monto de la cuota', color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _FeeDetailsShimmer extends StatelessWidget {
  const _FeeDetailsShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(height: 32),
            Container(
              height: 180,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
          ],
        ),
      ),
    );
  }
}
