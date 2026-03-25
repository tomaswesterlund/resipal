import 'package:flutter/material.dart';

class FloatingNavBarItem {
  final IconData icon;
  final String label;
  final bool showDanger;
  final int warningBadgeCount;
  final int badgeCount;

  FloatingNavBarItem({
    required this.icon,
    required this.label,
    this.showDanger = false,
    this.warningBadgeCount = 0,
    this.badgeCount = 0,
  });
}
