import 'package:flutter/material.dart';
import 'package:ui/lib.dart';
import 'package:core/lib.dart';

class PropertyHeader extends StatelessWidget {
  final PropertyEntity property;

  const PropertyHeader({required this.property, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    return GradientCard(
      child: Column(
        children: [
          // Sección Superior: Icono y Nombre de Propiedad
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home_work_outlined, color: Colors.white, size: 48),
              const SizedBox(width: 12),
              Expanded(child: HeaderText.two(property.name, color: Colors.white)),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 20),

          // Métricas Financieras de la Propiedad
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OverlineText('Deuda actual', color: Colors.white.withOpacity(0.8)),
              const SizedBox(height: 4),
              AmountText(
                amountInCents: property.totalDebtAmountInCents,
                fontSize: 42,
                color: Colors.white,
              ),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 16),

          // Sección Inferior: Residente y Estatus
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Columna Residente
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('RESIDENTE', color: Colors.white),
                    const SizedBox(height: 2),
                    BodyText.small(
                      property.resident?.name ?? 'SIN RESIDENTE',
                      color: property.resident == null ? Colors.orangeAccent : onPrimary.withOpacity(0.8),
                    ),
                  ],
                ),
              ),

              // Columna Estatus de Pago
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('ESTATUS', color: Colors.white),
                  const SizedBox(height: 4),
                  StatusBadge(
                    label: property.propertyPaymentStatus.display,
                    color: colorScheme.onPrimary,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
