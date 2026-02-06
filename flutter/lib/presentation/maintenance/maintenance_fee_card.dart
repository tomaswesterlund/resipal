import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/presentation/maintenance/maintenance_fee_icon.dart';
import 'package:resipal/presentation/maintenance/maintenance_status_pill.dart';

class MaintenanceFeeCard extends StatelessWidget {
  final MaintenanceFeeEntity maintenanceFee;
  const MaintenanceFeeCard(this.maintenanceFee, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      padding: 20,
      child: Column(
        children: [
          MaintenanceFeeIcon(maintenanceFee),
          const SizedBox(height: 16),
          AmountText(CurrencyFormatter.fromCents(maintenanceFee.amountInCents)),
          const SizedBox(height: 8),
          MaintenanceStatusPill(maintenanceFee),
        ],
      ),
    );
  }
}
