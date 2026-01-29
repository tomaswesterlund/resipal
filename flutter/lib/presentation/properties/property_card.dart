import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/presentation/properties/property_details_page.dart';
import 'package:short_navigation/short_navigation.dart';

class PropertyCard extends StatelessWidget {
  final PropertyEntity property;

  const PropertyCard(this.property, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool hasDebt = property.contract.totalOverdueFeeInCents > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hasDebt ? AppColors.danger.withOpacity(0.3) : AppColors.success.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Status Indicator Side Bar
              Container(width: 6, color: hasDebt ? AppColors.danger : AppColors.success),

              // 2. Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeaderText.five(
                            'Propiedad ${property.name}', // e.g., "Apt 402"
                          ),
                          Icon(
                            hasDebt
                                ? Icons.warning_amber_rounded
                                : Icons.check_circle_outline,
                            color: hasDebt ? AppColors.danger : AppColors.success,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        property.description ??
                            'NO DESC', // "Calle Falsa 123, Torre B"
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Deuda Pendiente',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AmountText.fromCents(
                                property.contract.totalOverdueFeeInCents,
                                fontSize: 18,
                                color: hasDebt ? AppColors.danger : Colors.black87,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () => Go.to(PropertyDetailsPage(property)),
                            child: const Text('Ver detalles'),
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
