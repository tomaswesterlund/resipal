import 'package:flutter/material.dart';
import 'package:resipal/core/ui/app_colors.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final List<FloatingNavBarItem> items;

  const FloatingNavBar({super.key, required this.currentIndex, required this.onChanged, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final bool isActive = currentIndex == index;

          return GestureDetector(
            onTap: () => onChanged(index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // Replace AppColors.secondary with your color if needed
                    color: isActive ? AppColors.secondaryScale[500] : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(item.icon, color: isActive ? Colors.white : Colors.grey, size: 24),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive ? AppColors.secondaryScale[500] : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class FloatingNavBarItem {
  final IconData icon;
  final String label;

  FloatingNavBarItem({required this.icon, required this.label});
}
