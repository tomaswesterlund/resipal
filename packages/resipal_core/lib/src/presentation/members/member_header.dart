import 'package:flutter/material.dart';
import 'package:wester_kit/lib.dart';
import 'package:resipal_core/lib.dart';

class MemberHeader extends StatelessWidget {
  final MemberEntity member;

  const MemberHeader({required this.member, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GradientCard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Property Identification
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_work_outlined, size: 16, color: colorScheme.onPrimary),
                const SizedBox(width: 8),
                HeaderText.one(member.name, color: colorScheme.onPrimary),
              ],
            ),
            const SizedBox(height: 4),

            const SizedBox(height: 24),
            Divider(height: 1, color: colorScheme.onPrimary.withOpacity(0.2)),
            const SizedBox(height: 24),

            // Financial Status Section
            OverlineText('Deuda Pendiente', color: colorScheme.onPrimary.withOpacity(0.7)),
            const SizedBox(height: 8),
            AmountText(
              amountInCents: member.totalMemberBalanceInCents,
              fontSize: 36,
              // We use a white-ish color for debt on gradient to keep it legible
              color: Colors.white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
