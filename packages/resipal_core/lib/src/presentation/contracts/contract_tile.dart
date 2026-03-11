import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/contracts/contract_details/contract_details_page.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class ContractTile extends StatelessWidget {
  final ContractEntity contract;

  const ContractTile({required this.contract, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Go.to(ContractDetailsPage(contract)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Icono de Contrato con énfasis en color primario
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1), 
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.assignment_outlined, 
                  size: 20, 
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),

              // 2. Columna: Información del Contrato
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Contrato'),
                    HeaderText.five(
                      contract.name,
                      color: colorScheme.onSurface,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    BodyText.tiny(
                      contract.period.toUpperCase(),
                      color: colorScheme.outline,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // 3. Columna: Monto de la Cuota
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('Cuota'),
                  const SizedBox(height: 4),
                  AmountText(
                    amountInCents: contract.amountInCents, 
                    fontSize: 16, 
                    color: colorScheme.primary,
                  ),
                ],
              ),

              const SizedBox(width: 12),
              // Chevron centrado visualmente
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Icon(Icons.chevron_right_rounded, size: 20, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}