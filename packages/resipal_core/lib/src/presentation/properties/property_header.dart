import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';
import 'package:resipal_core/lib.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFinanceItem(
                'DEUDA ACTUAL',
                property.totalDebtAmountInCents,
                onPrimary,
                accentColor: property.hasDebt ? Colors.redAccent : Colors.greenAccent,
              ),
              _buildFinanceItem('TOTAL PAGADO', property.totalPaidAmountInCents, onPrimary),
              _buildFinanceItem('CUOTAS', property.fees.length, onPrimary, isCurrency: false),
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
                      property.resident?.name ?? 'SIN ASIGNAR',
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
                    color: property.propertyPaymentStatus.color(colorScheme),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinanceItem(String label, int value, Color baseColor, {Color? accentColor, bool isCurrency = true}) {
    return Expanded(
      child: Column(
        children: [
          OverlineText(label, color: baseColor.withOpacity(0.7)),
          const SizedBox(height: 4),
          if (isCurrency)
            AmountText(
              amountInCents: value,
              fontSize: 16,
              color: (value != 0 && accentColor != null) ? accentColor : baseColor,
            )
          else
            Text(
              value.toString(),
              style: TextStyle(color: baseColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
