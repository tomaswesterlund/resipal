import 'package:flutter/material.dart';
import 'package:ui/lib.dart';

class InfoPopup extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color? iconColor;

  const InfoPopup({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.info_outline_rounded,
    this.iconColor,
  });

  /// Método estático para mostrarlo fácilmente
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    IconData icon = Icons.info_outline_rounded,
    Color? iconColor,
  }) {
    return showDialog(
      context: context,
      builder: (context) => InfoPopup(
        title: title,
        message: message,
        icon: icon,
        iconColor: iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (iconColor ?? colorScheme.primary).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: iconColor ?? colorScheme.primary),
          ),
          const SizedBox(height: 20),
          HeaderText.four(title, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          BodyText.medium(
            message,
            textAlign: TextAlign.center,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Entendido'),
            ),
          ),
        ],
      ),
    );
  }
}