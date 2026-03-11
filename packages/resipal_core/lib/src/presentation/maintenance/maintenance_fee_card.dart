import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/maintenance/maintenance_fee_details/maintenance_fee_details_page.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class MaintenanceFeeCard extends StatelessWidget {
  final MaintenanceFeeEntity fee;

  const MaintenanceFeeCard(this.fee, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final statusColor = fee.status.color(colorScheme);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: InkWell(
            onTap: () => Go.to(MaintenanceFeeDetailsPage(fee: fee)),
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
                                color: colorScheme.onSurface,
                              ),
                              const SizedBox(height: 2),

                              BodyText.small('Vence el ${fee.dueDate.toShortDate()}'),

                              if (fee.note != null && fee.note!.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                BodyText.tiny(fee.note!),
                              ],
                            ],
                          ),
                        ),

                        // Right Side: Amount and Status Pill
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AmountText(amountInCents: fee.amountInCents, fontSize: 17, color: fee.status.color(colorScheme),),
                            const SizedBox(height: 6),
                            MaintenanceStatusPill(fee),
                          ],
                        ),
                        const SizedBox(width: 12.0),
                        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: colorScheme.outlineVariant),
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
