import 'package:flutter/material.dart';

class WkFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  const WkFloatingActionButton({
    this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Resolves to Resipal Green (primary) if no color is provided
    final bg = backgroundColor ?? colorScheme.primary;
    // Resolves to White (onPrimary) if no color is provided
    final iconCol = iconColor ?? colorScheme.onPrimary;

    return FloatingActionButton(
      backgroundColor: bg,
      onPressed: onPressed,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Icon(icon, color: iconCol),
    );
  }
}
