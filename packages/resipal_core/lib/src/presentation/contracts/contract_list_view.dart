import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

class ContractListView extends StatelessWidget {
  final List<ContractEntity> contracts;
  const ContractListView(this.contracts, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    if (contracts.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(Icons.description_outlined, size: 64, color: colorScheme.primary),
              ),
              const SizedBox(height: 32),
              HeaderText.four('No hay contratos registrados', textAlign: TextAlign.center, color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                'Para registrar una propiedad, primero necesitas definir al menos un tipo de contrato (ej: Mensualidad, Mantenimiento).',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.inverseSurface),
              ),
              const SizedBox(height: 32),
              TextButton.icon(
                onPressed: () => Go.to(RegisterContractPage()),
                icon: const Icon(Icons.add),
                label: const Text('Registrar contrato'),
                style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 100.0),
      itemCount: contracts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => ContractCard(contracts[index]),
    );
  }
}
