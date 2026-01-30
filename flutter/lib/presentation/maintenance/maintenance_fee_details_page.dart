import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/formatters/id_formatter.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/section_header_text.dart';
import 'package:resipal/core/ui/tiles/detail_tile.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/presentation/maintenance/maintenance_fee_icon.dart';
import 'package:resipal/presentation/maintenance/maintenance_status_pill.dart';

class MaintenanceFeeDetailsPage extends StatelessWidget {
  final MaintenanceFeeEntity maintenanceFee;
  const MaintenanceFeeDetailsPage(this.maintenanceFee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                  MaintenanceFeeIcon(maintenanceFee),
                  const SizedBox(height: 16),
                  AmountText(
                    CurrencyFormatter.fromCents(maintenanceFee.amountInCents),
                  ),
                  const SizedBox(height: 8),
                  MaintenanceStatusPill(maintenanceFee),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SectionHeaderText(text: 'INFORMACIÓN GENERAL'),

            DefaultCard(
              padding: 0,
              child: Column(
                children: [
                  DetailTile(
                    icon: Icons.fingerprint,
                    label: 'ID de registro',
                    value: maintenanceFee.id.toShortId(),
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.note_outlined,
                    label: 'Contrato',
                    value: maintenanceFee.contract.name,
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.schedule_outlined,
                    label: 'Periodo',
                    value: DateFormatters.toDateRange(
                      maintenanceFee.fromDate,
                      maintenanceFee.toDate,
                    ),
                  ),
                  const Divider(height: 1),
                  DetailTile(
                    icon: Icons.schedule,
                    label: 'Fecha de vencimiento',
                    value: maintenanceFee.dueDate.toShortDate(),
                  ),
                  if (maintenanceFee.paymentDate != null) ...[
                    const Divider(height: 1),
                    DetailTile(
                      icon: Icons.credit_card_outlined,
                      label: 'Fecha de pago',
                      value: maintenanceFee.paymentDate!.toShortDate(),
                    ),
                  ],
                  if (maintenanceFee.note != null) ...[
                    const Divider(height: 1),
                    DetailTile(
                      icon: Icons.note_outlined,
                      label: 'Nota',
                      value: maintenanceFee.note!,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
