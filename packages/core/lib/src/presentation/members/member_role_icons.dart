import 'package:flutter/material.dart';
import 'package:core/lib.dart';

class MemberRoleIcons extends StatelessWidget {
  final MemberEntity member;
  final Color? color;
  final double size;

  const MemberRoleIcons({super.key, required this.member, this.color, this.size = 18});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (member.isAdmin) _buildIcon(Icons.admin_panel_settings_outlined, color ?? Color(0xFF6A95B9)),

        if (member.isResident) _buildIcon(Icons.home_work_outlined, color ?? Color(0xFF3C7873)),
        if (member.isSecurity) _buildIcon(Icons.shield_outlined, color ?? Color(0xFFC53A41)),
      ],
    );
  }

  Widget _buildIcon(IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Icon(icon, size: size, color: iconColor),
    );
  }
}
