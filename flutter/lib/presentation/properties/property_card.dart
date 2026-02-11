import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/amount_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/presentation/properties/property_details/property_details_page.dart';
import 'package:short_navigation/short_navigation.dart';

class PropertyCard extends StatelessWidget {
  final PropertyEntity property;

  const PropertyCard(this.property, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: property.hasDebt
              ? AppColors.danger.withOpacity(0.3)
              : AppColors.success.withOpacity(0.3),
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
              Container(
                width: 6,
                color: property.hasDebt ? AppColors.danger : AppColors.success,
              ),

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
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.house_outlined,
                                  size: 20,
                                  color: AppColors.secondaryScale[400],
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: HeaderText.five(
                                    property.name,
                                    color: AppColors.auxiliarScale[900]!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            property.hasDebt
                                ? Icons.warning_amber_rounded
                                : Icons.check_circle_outline,
                            color: property.hasDebt
                                ? AppColors.danger
                                : AppColors.success,
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
                       Divider(
                        height: 24,
                        thickness: 1,
                        color: AppColors.auxiliarScale[100]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deuda pendiente',
                                style: GoogleFonts.raleway(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.auxiliarScale[400],
                                ),
                              ),
                              AmountText.fromCents(
                                property.totalOverdueFeeInCents.toInt(),
                                //property.contract?.totalOverdueFeeInCents,
                                fontSize: 18,
                                color: property.hasDebt
                                    ? AppColors.danger
                                    : Colors.black87,
                              ),
                            ],
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.secondary,
                              textStyle: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            onPressed: () =>
                                Go.to(PropertyDetailsPage(property)),
                            child: Row(
                              children: [
                                Text('Detalles'),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_ios, size: 12),
                              ],
                            ),
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
