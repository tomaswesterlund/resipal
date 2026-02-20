import 'package:flutter/material.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';

class StatusPill extends StatelessWidget {
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;
  final IconData? icon;

  const StatusPill._({
    required this.child,
    required this.primaryColor,
    required this.secondaryColor,
    this.icon,
  });

  factory StatusPill.success({required Widget child, IconData? icon}) {
    return StatusPill._(
      child: child,
      primaryColor: BaseAppColors.success,
      secondaryColor: BaseAppColors.surface,
      icon: icon ?? Icons.check_circle_outline_rounded,
    );
  }

  factory StatusPill.warning({required Widget child, IconData? icon}) {
    return StatusPill._(
      child: child,
      primaryColor: BaseAppColors.warning,
      secondaryColor: BaseAppColors.surface,
      icon: icon ?? Icons.history_toggle_off_rounded,
    );
  }

  factory StatusPill.danger({required Widget child, IconData? icon}) {
    return StatusPill._(
      child: child,
      primaryColor: BaseAppColors.danger,
      secondaryColor: BaseAppColors.surface,
      icon: icon ?? Icons.error_outline_rounded,
    );
  }

  factory StatusPill.info({required Widget child, IconData? icon}) {
    return StatusPill._(
      child: child,
      primaryColor: BaseAppColors.info,
      secondaryColor: BaseAppColors.surface,
      icon: icon ?? Icons.info_outline_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(20),
        // Using a slightly more opaque primary for the border to give definition
        border: Border.all(color: primaryColor.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: primaryColor),
            const SizedBox(width: 6),
          ],
          DefaultTextStyle.merge(
            style: TextStyle(
              color: primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}