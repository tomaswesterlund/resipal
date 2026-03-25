import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:core/src/presentation/access/access_page.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/lib.dart';

class ResidentHomeOverview extends StatelessWidget {
  final ResidentMemberEntity resident;
  const ResidentHomeOverview({required this.resident, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderText.four('¡Bienvenido, ${resident.user.name}!'),
              const SizedBox(height: 4),
              Text(
                resident.community.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              GradientCard(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Encabezado Principal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => InfoPopup.show(
                            context,
                            title: 'SALDO ACTUAL',
                            message:
                                'Es el balance final de tu cuenta. Se calcula sumando todos tus pagos aprobados y restando el total de cuotas y cargos generados a tu propiedad.',
                          ),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                HeaderText.four('SALDO ACTUAL', color: Colors.white.withOpacity(0.9)),
                                const SizedBox(width: 6),
                                Icon(Icons.info_outline_rounded, size: 14, color: Colors.white.withOpacity(0.5)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    AmountText(amountInCents: resident.totalMemberBalanceInCents, color: Colors.white, fontSize: 32),

                    const SizedBox(height: 24),
                    Divider(color: Colors.white.withOpacity(0.2)),
                    const SizedBox(height: 16),

                    // Fila de detalles adicionales
                    Row(
                      children: [
                        Expanded(
                          child: _FinancialDetail(
                            label: 'EN REVISIÓN',
                            amount: resident.paymentLedger.pendingPaymentAmountInCents,
                            helpText:
                                'Pagos que has registrado pero que aún están pendientes de validación por la administración.',
                          ),
                        ),

                        Container(height: 30, width: 1, color: Colors.white.withOpacity(0.2)),

                        Expanded(
                          child: _FinancialDetail(
                            label: 'DEUDA TOTAL',
                            amount: resident.propertyRegistry.totalDebtAmountInCents,
                            isAlert: resident.hasDebt,
                            helpText:
                                'Monto total de cuotas, multas o cargos vencidos que no presentan un pago asociado.',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
                    child: HeaderText.five('Acciones'),
                  ),
                  Column(
                    children: [
                      ActionTile(
                        title: 'Propiedades con deuda',
                        count: resident.propertyRegistry.withOverduesFees.length,
                        icon: Icons.house_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => Go.to(PropertiesPage(resident.propertyRegistry)),
                      ),
                      SizedBox(height: 4),
                      ActionTile(
                        title: 'Pagos en revisión',
                        count: resident.paymentLedger.pendingPayments.length,
                        icon: Icons.attach_money,
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => Go.to(PaymentsPage(ledger: resident.paymentLedger)),
                      ),
                      SizedBox(height: 4),
                      ActionTile(
                        title: 'Accesos activos',
                        count: resident.accessRegistry.activeInvitations.length,
                        icon: Icons.door_front_door_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () => Go.to(AccessPage(resident.accessRegistry)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FinancialDetail extends StatelessWidget {
  final String label;
  final int amount;
  final bool isAlert;
  final String? helpText;

  const _FinancialDetail({required this.label, required this.amount, this.isAlert = false, this.helpText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Usamos el método estático de InfoPopup
      onTap: helpText != null
          ? () => InfoPopup.show(
              context,
              title: label,
              message: helpText!,
              // El icono cambia a alerta si hay deuda, si no, info
              icon: isAlert ? Icons.warning_amber_rounded : Icons.info_outline_rounded,
            )
          : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                if (helpText != null) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.info_outline_rounded, size: 12, color: Colors.white.withOpacity(0.5)),
                ],
              ],
            ),
            const SizedBox(height: 4),
            AmountText(
              amountInCents: amount,
              color: isAlert ? Colors.white : Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
