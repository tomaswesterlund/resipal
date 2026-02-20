import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal_core/helpers/formatters/currency_formatter.dart';
import 'package:resipal_core/helpers/formatters/date_formatters.dart';
import 'package:resipal_core/helpers/formatters/id_formatter.dart';
import 'package:resipal_core/presentation/maintenance/widgets/maintenance_fee_icon.dart';
import 'package:resipal_core/presentation/maintenance/widgets/maintenance_status_pill.dart';
import 'package:resipal_core/presentation/shared/buttons/cta/primary_cta_button.dart';
import 'package:resipal_core/presentation/shared/cards/default_card.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';
import 'package:resipal_core/presentation/shared/my_app_bar.dart';
import 'package:resipal_core/presentation/shared/texts/amount_text.dart';
import 'package:resipal_core/presentation/shared/texts/section_header_text.dart';
import 'package:resipal_core/presentation/shared/tiles/detail_tile.dart';

class MaintenanceFeeDetailsPage extends StatelessWidget {
  final MaintenanceFeeEntity fee;
  const MaintenanceFeeDetailsPage(this.fee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseAppColors.background,
      appBar: MyAppBar(title: 'Detalle de Cuota'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            DefaultCard(
              padding: 20,
              child: Column(
                children: [
                  MaintenanceFeeIcon(fee),
                  const SizedBox(height: 16),
                  AmountText(CurrencyFormatter.fromCents(fee.amountInCents)),
                  const SizedBox(height: 8),
                  MaintenanceStatusPill(fee),
                ],
              ),
            ),
            const SizedBox(height: 12),
            PrimaryCtaButton(label: 'Pagar mantenimiento', onPressed: () {}, icon: Icons.attach_money),
            const SizedBox(height: 24),

            SectionHeaderText(text: 'INFORMACIÓN GENERAL'),

            DefaultCard(
              padding: 0,
              child: Column(
                children: [
                  DetailTile(icon: Icons.fingerprint, label: 'ID de registro', value: fee.id.toShortId()),
                  const Divider(height: 1),
                  DetailTile(icon: Icons.note_outlined, label: 'Contrato', value: fee.contract.name),
                  const Divider(height: 1),
                  DetailTile(icon: Icons.schedule_outlined, label: 'Periodo', value: DateFormatters.toDateRange(fee.fromDate, fee.toDate)),
                  const Divider(height: 1),
                  DetailTile(icon: Icons.schedule, label: 'Fecha de vencimiento', value: fee.dueDate.toShortDate()),
                  if (fee.paymentDate != null) ...[
                    const Divider(height: 1),
                    DetailTile(icon: Icons.credit_card_outlined, label: 'Fecha de pago', value: fee.paymentDate!.toShortDate()),
                  ],
                  if (fee.note != null) ...[const Divider(height: 1), DetailTile(icon: Icons.note_outlined, label: 'Nota', value: fee.note!)],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
