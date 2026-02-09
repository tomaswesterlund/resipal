import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal/core/formatters/date_formatters.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';

class VisitorCard extends StatelessWidget {
  final VisitorEntity visitor;
  final VoidCallback? onTap;

  const VisitorCard(this.visitor, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.secondaryScale[100]!, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Status Indicator Side Bar (Using brand secondary color)
              Container(width: 6, color: AppColors.secondary),

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
                                Icon(Icons.person_outline_rounded, size: 20, color: AppColors.secondaryScale[400]),
                                const SizedBox(width: 8),
                                Flexible(child: HeaderText.five(visitor.name, color: AppColors.auxiliarScale[900]!)),
                              ],
                            ),
                          ),
                          // Optional: Badge icon to indicate ID is registered
                          Icon(Icons.badge_outlined, color: AppColors.secondaryScale[300], size: 18),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Registrado el ${visitor.createdAt.toShortDate()}',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                      Divider(height: 24, thickness: 1, color: AppColors.auxiliarScale[100]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Identificación',
                                style: GoogleFonts.raleway(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.auxiliarScale[400],
                                ),
                              ),
                              const Text(
                                'Documento cargado',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                              ),
                            ],
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.secondary,
                              textStyle: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            onPressed: onTap,
                            child: const Row(
                              children: [Text('Ver ID'), SizedBox(width: 4), Icon(Icons.visibility_outlined, size: 14)],
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
