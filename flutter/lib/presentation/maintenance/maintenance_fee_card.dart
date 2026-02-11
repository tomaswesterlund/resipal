import 'package:flutter/material.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/maintenance_fee_entity.dart';
import 'package:resipal/domain/enums/maintenance_fee_status.dart';
import 'package:resipal/presentation/maintenance/maintenance_fee_details_page.dart';
import 'package:resipal/presentation/maintenance/maintenance_status_pill.dart';
import 'package:short_navigation/short_navigation.dart';

class MaintenanceFeeCard extends StatelessWidget {
  final MaintenanceFeeEntity fee;

  const MaintenanceFeeCard(this.fee, {super.key});

  Color _getStatusColor() {
    switch (fee.status) {
      case MaintenanceFeeStatus.paid:
        return AppColors.success;
      case MaintenanceFeeStatus.overdue:
        return AppColors.danger;
      case MaintenanceFeeStatus.pending:
        return Colors.orange;
      case MaintenanceFeeStatus.upcoming:
        return AppColors.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: InkWell(
            onTap: () => Go.to(MaintenanceFeeDetailsPage(fee)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Status Indicator Side Bar
                Container(width: 5, color: statusColor),

                // 2. Main Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: [
                        // Left Side: Period and Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeaderText.five(
                                DateFormatters.toDateRange(fee.fromDate, fee.toDate),
                                color: AppColors.auxiliarScale[900]!,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Vence el ${fee.dueDate.toShortDate()}',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                              ),
                              if (fee.note != null && fee.note!.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  fee.note!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),


                        // Right Side: Amount and Status Pill
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AmountText.fromCents(fee.amountInCents, fontSize: 17, color: AppColors.auxiliarScale[900]!),
                            const SizedBox(height: 6),
                            // Reusing your existing Pill component
                            MaintenanceStatusPill(fee),
                          ],
                        ),
                        SizedBox(width: 12.0,),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
