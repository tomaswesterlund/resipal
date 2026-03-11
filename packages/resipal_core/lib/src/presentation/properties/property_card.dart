import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';
import 'package:short_navigation/short_navigation.dart';

class PropertyCard extends StatelessWidget {
  final PropertyEntity property;
  const PropertyCard(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Get the status from the entity
    final status = property.propertyPaymentStatus;
    // Get the color and icon from the enum implementation
    final Color statusColor = status.color(colorScheme);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Visual status indicator bar
              Container(width: 6, color: statusColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.house_outlined, size: 36, color: colorScheme.onPrimaryContainer),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OverlineText('PROPIEDAD'),
                                    HeaderText.five(property.name, color: colorScheme.primary),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OverlineText('RESIDENTE'),
                                    BodyText.small(property.resident?.name ?? 'Sin residente asignado'),
                                  ],
                                ),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                status.display.toUpperCase(), // From Enum
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontSize: 9,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w800,
                                  color: colorScheme.outline,
                                ),
                              ),
                              const SizedBox(height: 2),
                              AmountText(
                                amountInCents: property.totalDebtAmountInCents,
                                fontSize: 18,
                                color: statusColor,
                              ),
                            ],
                          ),
                          ActionLink(
                            label: 'Detalles',
                            onTap: () => Go.to(PropertyDetailsPage(property: property)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
