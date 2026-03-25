import 'package:flutter/material.dart';

class ActionLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData icon;
  final Color? color;

  const ActionLink({
    required this.label,
    required this.onTap,
    this.icon = Icons.arrow_forward_ios,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final activeColor = color ?? colorScheme.primary;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: activeColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(color: activeColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Icon(icon, size: 12, color: activeColor),
        ],
      ),
    );
  }
}
