import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class PaymentHeader extends StatelessWidget {
  final PaymentEntity payment;
  const PaymentHeader(this.payment, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    return GradientCard(
      child: Column(
        children: [
          // Sección Superior: Icono y Monto Principal
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.attach_money_outlined,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OverlineText('MONTO PAGADO', color: onPrimary.withOpacity(0.7)),
                    AmountText(
                      amountInCents: payment.amountInCents,
                      fontSize: 32,
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

          // Detalles de la Transacción
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // _buildTransactionItem(
              //   'MÉTODO',
              //   payment.method.display, // Asumiendo que el enum tiene display
              //   onPrimary,
              //   icon: Icons.account_balance_wallet_outlined,
              // ),
              _buildTransactionItem(
                'FECHA DE PAGO',
                payment.date.toShortDate(),
                onPrimary,
                icon: Icons.calendar_today_rounded,
              ),
              _buildTransactionItem(
                'REF',
                payment.reference?.isNotEmpty == true ? payment.reference! : 'Sin referencia',
                onPrimary,
                icon: Icons.tag_rounded,
              ),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 16),

          // Sección Inferior: Usuario y Estatus
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Identidad de quien realizó el pago
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('PAGADO POR', color: Colors.white),
                    const SizedBox(height: 2),
                    BodyText.small(
                      payment.user.name,
                      color: onPrimary.withOpacity(0.8),
                    ),
                  ],
                ),
              ),

              // Estatus del Pago (Pill de WesterKit)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('ESTATUS', color: Colors.white),
                  const SizedBox(height: 4),
                  PaymentStatusPill(payment), 
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String label, String value, Color baseColor, {required IconData icon}) {
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
          BodyText.small(
            value,
            color: baseColor,
            fontWeight: FontWeight.bold,
            // maxLines: 1,
          ),
        ],
      ),
    );
  }
}