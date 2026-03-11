import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/members/member_role_icons.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/lib.dart';

class MemberTile extends StatelessWidget {
  final MemberEntity member;

  const MemberTile({required this.member, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Lógica visual basada en deuda
    final Color statusColor = member.hasDebt
        ? colorScheme.error
        : Colors.green; 

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Go.to(MemberDetailsPage(member: member)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Row(
            children: [
              // 1. Icono de Perfil
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(Icons.person_outline_rounded, size: 20, color: statusColor),
              ),
              const SizedBox(width: 16),

              // 2. Columna: Nombre
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OverlineText('Nombre'),
                    HeaderText.five(
                      member.name,
                      color: colorScheme.onSurface,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // 3. Columna: Roles
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OverlineText('Roles'),
                  const SizedBox(height: 4), // Espacio para alinear con el texto del header
                  MemberRoleIcons(member: member, size: 16),
                ],
              ),

              const SizedBox(width: 12),
              const Icon(Icons.chevron_right_rounded, size: 20, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}