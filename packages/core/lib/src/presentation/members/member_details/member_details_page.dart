import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';

class MemberDetailsPage extends StatelessWidget {
  final MemberEntity member;
  const MemberDetailsPage({required this.member, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: MyAppBar(title: member.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MemberHeader(member: member),
            const SizedBox(height: 32),

            const SectionHeaderText(text: 'INFORMACIÓN DE CONTACTO'),
            DefaultCard(
              child: Column(
                children: [
                  DetailTile(
                    icon: Icons.email_outlined,
                    label: 'Correo electrónico',
                    value: member.user.email,
                    enableCopy: true
                  ),
                  Divider(height: 1, color: colorScheme.outlineVariant),
                  DetailTile(
                    icon: Icons.phone_outlined,
                    label: 'Teléfono',
                    value: PhoneFormatter.toDisplay(member.user.phoneNumber),
                    enableCopy: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const SectionHeaderText(text: 'ROLES ASIGNADOS'),
            DefaultCard(
              child: Column(
                children: [
                  DetailTile(
                    icon: Icons.admin_panel_settings_outlined,
                    label: 'Administrador',
                    value: member.isAdmin ? 'Activo' : 'Inactivo',
                    color: member.isAdmin ? colorScheme.primary : colorScheme.outline,
                  ),
                  Divider(height: 1, color: colorScheme.outlineVariant),
                  DetailTile(
                    icon: Icons.home_work_outlined,
                    label: 'Residente',
                    value: member.isResident ? 'Activo' : 'Inactivo',
                    color: member.isResident ? colorScheme.primary : colorScheme.outline,
                  ),
                  Divider(height: 1, color: colorScheme.outlineVariant),
                  DetailTile(
                    icon: Icons.shield_outlined,
                    label: 'Seguridad',
                    value: member.isSecurity ? 'Activo' : 'Inactivo',
                    color: member.isSecurity ? colorScheme.primary : colorScheme.outline,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
