import 'package:flutter/material.dart';
import 'package:ui/inputs/fab/badge_indicator.dart';
import 'package:ui/inputs/fab/floating_nav_bar_item.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final List<FloatingNavBarItem> items;
  final Function(int) onChanged;

  // Optional Color Overrides (Defaults to Theme)
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? dangerColor;
  final Color? warningColor;
  final Color? infoColor;
  final Color? badgeTextColor;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    required this.items,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.dangerColor,
    this.warningColor,
    this.infoColor,
    this.badgeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Resolve Colors: Priority (Constructor -> Theme -> Fallback)
    final bg = backgroundColor ?? colorScheme.surface;
    final active = activeColor ?? colorScheme.primary;
    final inactive = inactiveColor ?? colorScheme.outline;
    final danger = dangerColor ?? colorScheme.error;
    final warning = warningColor ?? Colors.orange; // Custom fallback if not in scheme
    final info = infoColor ?? colorScheme.tertiary;
    final bTextColor = badgeTextColor ?? colorScheme.onPrimary;

    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: active.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final bool isActive = currentIndex == index;
          final currentColor = isActive ? active : inactive;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isActive ? active.withOpacity(0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(item.icon, color: currentColor, size: 24),
                      ),

                      // Badge Logic
                      if (item.showDanger || item.warningBadgeCount > 0 || item.badgeCount > 0)
                        Positioned(
                          top: -2,
                          right: -2,
                          child: BadgeIndicator(
                            color: item.showDanger ? danger : (item.warningBadgeCount > 0 ? warning : info),
                            text: item.showDanger
                                ? '!'
                                : (item.warningBadgeCount > 0
                                      ? item.warningBadgeCount.toString()
                                      : item.badgeCount.toString()),
                            borderColor: bg,
                            textColor: bTextColor,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 9,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: currentColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
