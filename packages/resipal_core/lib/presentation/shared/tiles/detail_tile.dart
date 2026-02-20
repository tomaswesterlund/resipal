import 'package:flutter/material.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color; // Add this

  const DetailTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.color, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Use the passed color, or fallback to primary
      leading: Icon(icon, color: color ?? BaseAppColors.secondary, size: 22),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}
