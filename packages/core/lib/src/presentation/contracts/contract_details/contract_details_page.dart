import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';

class ContractDetailsPage extends StatelessWidget {
  final ContractEntity contract;
  const ContractDetailsPage(this.contract, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const MyAppBar(title: 'Detalle de Contrato'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ContractHeaderCard(contract: contract),
            const SizedBox(height: 24),
            const SectionHeaderText(text: 'CONFIGURACIÓN DEL CONTRATO'),
            DefaultCard(
              child: Column(
                children: [
                  DetailTile(icon: Icons.repeat_rounded, label: 'Periodicidad', value: contract.period),
                  Divider(height: 1, color: Colors.grey.withOpacity(0.1)),
                  DetailTile(
                    icon: Icons.calendar_today_outlined,
                    label: 'Fecha de creación',
                    value: contract.createdAt.toShortDate(),
                  ),
                ],
              ),
            ),
            if (contract.description != null && contract.description!.isNotEmpty) ...[
              const SizedBox(height: 24),
              const SectionHeaderText(text: 'DESCRIPCIÓN'),
              DefaultCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BodyText.medium(contract.description!, color: colorScheme.onSurfaceVariant),
                ),
              ),
            ],
            const SizedBox(height: 32),
            // Example Action: Usually contracts might have associated fees to view
            // SecondaryButton(
            //   label: 'Ver cuotas asociadas',
            //   onPressed: () {
            //     // TODO: Navigate to fees filtered by this contract
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class _ContractHeaderCard extends StatelessWidget {
  final ContractEntity contract;
  const _ContractHeaderCard({required this.contract});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    return GradientCard(
      child: Column(
        children: [
          // Sección Superior: Icono y Nombre del Contrato
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.description_outlined,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OverlineText('CONTRATO DE MANTENIMIENTO', color: onPrimary.withOpacity(0.7)),
                    HeaderText.two(
                      contract.name,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 20),

          // Métricas del Contrato
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildContractStat(
                'MONTO BASE',
                CurrencyFormatter.fromCents(contract.amountInCents),
                onPrimary,
                icon: Icons.attach_money_rounded,
              ),
              _buildContractStat(
                'PERIODICIDAD',
                'Mensual', 
                onPrimary,
                icon: Icons.repeat_rounded,
              ),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 16),

          // Sección Inferior: Estatus Legal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('TIPO DE PROPIEDAD', color: Colors.white),
                    const SizedBox(height: 2),
                    BodyText.small(
                      'Residencial', // O el dato dinámico correspondiente
                      color: onPrimary.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('ESTADO LEGAL', color: Colors.white),
                  const SizedBox(height: 4),
                  const StatusBadge(
                    label: 'CONTRATO ACTIVO',
                    color: Colors.white, // Resalta sobre el gradiente
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContractStat(String label, String value, Color baseColor, {required IconData icon}) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 10, color: baseColor.withOpacity(0.6)),
              const SizedBox(width: 4),
              OverlineText(label, color: baseColor.withOpacity(0.6)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: baseColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
