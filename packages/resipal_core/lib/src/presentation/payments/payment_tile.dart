import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class PaymentTile extends StatelessWidget {
  final PaymentEntity payment;

  const PaymentTile({required this.payment, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color statusColor = payment.status.color(colorScheme);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Go.to(PaymentDetailsPage(payment: payment)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            children: [
              // 1. Icono de estatus
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(Icons.receipt_long_outlined, size: 20, color: statusColor),
              ),
              const SizedBox(width: 16),

              // 2. Columna: Monto
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Monto pagado'),
                    AmountText(amountInCents: payment.amountInCents, fontSize: 16, color: statusColor),
                  ],
                ),
              ),
              SizedBox(width: 8),

              // 3. Columna: Usuario
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Pagado por'),
                    BodyText.medium(payment.user.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),

              // 4. Columna: Fecha (Discreta)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('Fecha'),
                  const SizedBox(height: 2),
                  BodyText.tiny(payment.date.toShortDate(), color: colorScheme.outline),
                ],
              ),

              const SizedBox(width: 12),
              const Icon(Icons.chevron_right_rounded, size: 20, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}
