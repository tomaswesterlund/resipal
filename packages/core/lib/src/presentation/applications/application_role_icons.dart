import 'package:flutter/material.dart';
import 'package:core/lib.dart';

class ApplicationRoleIcons extends StatelessWidget {
  final ApplicationEntity application;
  final Color? color;
  final double size;

  const ApplicationRoleIcons({
    super.key,
    required this.application,
    this.color,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (application.isAdmin) 
          _buildIcon(
            Icons.admin_panel_settings, 
            color ?? colorScheme.primary, // Mismo color que en RolesPage
          ),
        if (application.isSecurity) 
          _buildIcon(
            Icons.shield_outlined, 
            color ?? colorScheme.secondary, // Mismo color que en RolesPage
          ),
        if (application.isResident) 
          _buildIcon(
            Icons.home_work_outlined, 
            color ?? colorScheme.outline, // Mismo color que en RolesPage
          ),
      ],
    );
  }

  Widget _buildIcon(IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Icon(icon, size: size, color: iconColor),
    );
  }
}