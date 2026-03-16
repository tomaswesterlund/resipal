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

    // Lógica visual: Usamos el primary para un look institucional 
    // o podrías cambiarlo a 'error' si detectas alguna condición especial en el futuro.
    final Color accentColor = colorScheme.primary; 

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        // Asumiendo que MemberDetailsPage acepta la nueva MemberEntity
        onTap: () => Go.to(MemberDetailsPage(member: member)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              // 1. Icono de Perfil con el nuevo color Primary (Oxford Blue)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1), 
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline_rounded, 
                  size: 20, 
                  color: accentColor,
                ),
              ),
              const SizedBox(width: 16),

              // 2. Columna: Información del Miembro
              Expanded(
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

              // 3. Columna: Roles (Usando tus iconos de rol existentes)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const OverlineText('Roles'),
                  const SizedBox(height: 4),
                  MemberRoleIcons(member: member, size: 18),
                ],
              ),

              const SizedBox(width: 12),
              Icon(
                Icons.chevron_right_rounded, 
                size: 20, 
                color: colorScheme.onSurfaceVariant.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
