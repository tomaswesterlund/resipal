import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';
import 'package:resipal_core/lib.dart';

class PropertyHeader extends StatelessWidget {
  final PropertyEntity property;

  const PropertyHeader({required this.property, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GradientCard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Property Identification
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_work_outlined, size: 16, color: colorScheme.onPrimary),
                const SizedBox(width: 8),
                HeaderText.one(property.name, color: colorScheme.onPrimary),
              ],
            ),
            const SizedBox(height: 4),

            // Resident Info
            if (property.resident != null)
              BodyText.medium(property.resident!.name, color: colorScheme.onPrimary.withOpacity(0.8))
            else
              const StatusBadge(color: Colors.orange, label: 'SIN RESIDENTE'),

            const SizedBox(height: 24),
            Divider(height: 1, color: colorScheme.onPrimary.withOpacity(0.2)),
            const SizedBox(height: 24),

            // Financial Status Section
            OverlineText('Deuda Pendiente', color: colorScheme.onPrimary.withOpacity(0.7)),
            const SizedBox(height: 8),
            AmountText(
              amountInCents: property.totalDebtAmountInCents,
              fontSize: 36,
              // We use a white-ish color for debt on gradient to keep it legible
              color: property.hasDebt ? Colors.white : Colors.greenAccent,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            BodyText.small(
              property.hasDebt ? 'Saldo por liquidar' : 'Sin adeudos pendientes',
              color: colorScheme.onPrimary.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
