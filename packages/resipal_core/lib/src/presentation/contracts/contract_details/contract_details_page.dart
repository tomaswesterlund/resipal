import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

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

    return DefaultCard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const StatusBadge(color: Colors.blue, label: 'Contrato Activo'),
            const SizedBox(height: 16),
            HeaderText.three(contract.name, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            AmountText(amountInCents: contract.amountInCents, fontSize: 32, textAlign: TextAlign.center, color: Colors.black),
            BodyText.small('Monto base estipulado', color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
