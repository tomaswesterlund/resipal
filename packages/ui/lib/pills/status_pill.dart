import 'package:flutter/material.dart';

/// A standalone status indicator for Westerlund Solutions projects.
/// Uses Material defaults to ensure zero external dependencies.
class StatusPill extends StatelessWidget {
  final Widget child;
  final Color primaryColor;
  final Color backgroundColor;
  final IconData? icon;

  const StatusPill._({required this.child, required this.primaryColor, required this.backgroundColor, this.icon});

  /// Success state: Uses standard Emerald/Green tones.
  factory StatusPill.success({required Widget child, IconData? icon}) {
    return StatusPill._(
      child: child,
      primaryColor: Colors.green.shade800,
      backgroundColor: Colors.green.shade50,
      icon: icon ?? Icons.check_circle_outline_rounded,
    );
  }

  /// Warning state: Uses Amber/Orange tones.
  factory StatusPill.warning({required Widget child, IconData? icon}) {
    return StatusPill._(
      child: child,
      primaryColor: Colors.orange.shade700,
      backgroundColor: Colors.orange.shade50,
      icon: icon ?? Icons.history_toggle_off_rounded,
    );
  }

  /// Danger state: Uses Crimson/Red tones.
  factory StatusPill.danger({required Widget child, IconData? icon}) {
    return StatusPill._(
      child: child,
      primaryColor: Colors.red.shade800,
      backgroundColor: Colors.red.shade50,
      icon: icon ?? Icons.error_outline_rounded,
    );
  }

  /// Info state: Uses Azure/Blue tones.
  factory StatusPill.info({required Widget child, IconData? icon}) {
    return StatusPill._(
      child: child,
      primaryColor: Colors.blue.shade800,
      backgroundColor: Colors.blue.shade50,
      icon: icon ?? Icons.info_outline_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.15), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 14, color: primaryColor), const SizedBox(width: 6)],
          DefaultTextStyle.merge(
            style: TextStyle(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            child: child,
          ),
        ],
      ),
    );
  }
}
