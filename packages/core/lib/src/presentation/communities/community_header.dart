import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:core/lib.dart';
import 'package:ui/extensions/formatters/currency_formatter.dart';
import 'package:ui/cards/gradient_card.dart';
import 'package:ui/texts/body_text.dart';
import 'package:ui/texts/header_text.dart';
import 'package:ui/texts/overline_text.dart';

class CommunityHeader extends StatelessWidget {
  final CommunityEntity community;
  const CommunityHeader(this.community);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final onPrimary = colorScheme.onPrimary;

    return GradientCard(
      child: Column(
        children: [
          // Sección Superior: Branding de la Comunidad
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_city_rounded, color: Colors.white, size: 48),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText.two(community.name, color: Colors.white),
                    BodyText.small(community.location, color: onPrimary.withOpacity(0.7)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 20),

          // Métricas Operativas Globales
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                'MIEMBROS',
                community.directory.count.toString(), // Asumiendo que existe el getter
                onPrimary,
                icon: Icons.people_outline_rounded,
              ),
              _buildStatItem(
                'PROPIEDADES',
                community.registry.count.toString(),
                onPrimary,
                icon: Icons.home_work_outlined,
              ),
              _buildStatItem(
                'SALDO',
                CurrencyFormatter.fromCents(community.totalBalanceInCents),
                onPrimary,
                icon: Icons.account_balance_rounded,
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color baseColor, {required IconData icon}) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 10, color: baseColor.withOpacity(0.6)),
              const SizedBox(width: 4),
              OverlineText(label, color: baseColor.withOpacity(0.6)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: baseColor, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: -0.5),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
