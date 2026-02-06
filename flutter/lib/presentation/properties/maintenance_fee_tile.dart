import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/presentation/maintenance/maintenance_fee_icon.dart';
import 'package:resipal/presentation/maintenance/maintenance_status_pill.dart';

class MaintenanceFeeTile extends StatelessWidget {
  final MaintenanceFeeEntity fee;
  final VoidCallback? onTap;

  const MaintenanceFeeTile(this.fee, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultCard(
      padding: 12,
      onTap: onTap,
      child: Row(
        children: [
          // Smaller icon version
          SizedBox(width: 40, height: 40, child: MaintenanceFeeIcon(fee)),
          const SizedBox(width: 12),

          // Period and Note
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormatters.toDateRange(fee.fromDate, fee.toDate),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                if (fee.note != null && fee.note!.isNotEmpty)
                  Text(
                    fee.note!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
              ],
            ),
          ),

          // Price and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AmountText(CurrencyFormatter.fromCents(fee.amountInCents), fontSize: 16),
              const SizedBox(height: 4),
              // We use Transform.scale or a smaller pill version if necessary
              MaintenanceStatusPill(fee),
            ],
          ),
        ],
      ),
    );
  }
}
