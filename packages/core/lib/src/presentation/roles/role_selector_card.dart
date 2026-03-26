import 'package:flutter/material.dart';
import 'package:ui/lib.dart';

class RoleSelectorCard extends StatelessWidget {
  final bool isResident;
  final bool isAdmin;
  final bool isSecurity;
  final String? errorText;
  final ValueChanged<bool?> onResidentChanged;
  final ValueChanged<bool?> onAdminChanged;
  final ValueChanged<bool?> onSecurityChanged;

  const RoleSelectorCard({
    required this.isResident,
    required this.isAdmin,
    required this.isSecurity,
    required this.onResidentChanged,
    required this.onAdminChanged,
    required this.onSecurityChanged,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultCard(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: hasError ? colorScheme.error : colorScheme.outlineVariant, width: hasError ? 2 : 1),
          ),
          child: Column(
            children: [
              CheckboxListTile(
                title: BodyText.medium('Administrador'),
                value: isAdmin,
                onChanged: onAdminChanged,
                activeColor: colorScheme.primary,
              ),
              CheckboxListTile(
                title: BodyText.medium('Residente'),
                value: isResident,
                onChanged: onResidentChanged,
                activeColor: colorScheme.primary,
              ),

              CheckboxListTile(
                title: BodyText.medium('Seguridad'),
                value: isSecurity,
                onChanged: onSecurityChanged,
                activeColor: colorScheme.primary,
              ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Text(errorText!, style: TextStyle(color: colorScheme.error, fontSize: 12)),
          ),
      ],
    );
  }
}
