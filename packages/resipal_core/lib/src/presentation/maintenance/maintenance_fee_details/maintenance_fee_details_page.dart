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
                DetailTile(
                  icon: Icons.event_available,
                  label: 'Fecha Límite de Pago',
                  value: fee.dueDate.toShortDate(),
                ),
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
    final onPrimary = Colors.white; // En GradientCard usualmente usamos blanco para contraste

    return GradientCard(
      child: Column(
        children: [
          // 1. Badge de Estatus Superior (Sobre el gradiente)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatusBadge(
                color: fee.status.color(colorScheme),
                label: fee.status.display.toUpperCase(),
                // Podrías considerar un estilo más claro si el GradientCard es muy oscuro
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2. Monto Central (Héroe)
          Column(
            children: [
              OverlineText('MONTO TOTAL A PAGAR', color: onPrimary.withOpacity(0.7)),
              const SizedBox(height: 4),
              AmountText(amountInCents: fee.amountInCents, fontSize: 36, color: onPrimary),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: onPrimary.withOpacity(0.2), height: 1),
          const SizedBox(height: 20),

          // 3. Métricas de la Cuota (Fechas y Contrato)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('VENCIMIENTO', fee.dueDate.toShortDate(), onPrimary, icon: Icons.calendar_today_rounded),
              _buildStatItem(
                'PERIODO',
                '${fee.fromDate.month}/${fee.fromDate.year}',
                onPrimary,
                icon: Icons.date_range_rounded,
              ),
              _buildStatItem('CONTRATO', fee.contract.name, onPrimary, icon: Icons.assignment_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color baseColor, {required IconData icon}) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 12, color: baseColor.withOpacity(0.6)),
              const SizedBox(width: 4),
              OverlineText(label, color: baseColor.withOpacity(0.6)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: baseColor,
              fontSize: 14, // Un poco más pequeño para que quepan 3 items cómodamente
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
