import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool canSubmit;
  final bool isSubmitting;
  final IconData? icon;
  final Color? borderColor;

  const SecondaryButton({
    required this.label,
    required this.onPressed,
    this.canSubmit = true,
    this.isSubmitting = false,
    this.icon,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Color principal para el borde y el texto
    final Color strokeColor = borderColor ?? colorScheme.primary;
    
    final bool isEnabled = canSubmit && !isSubmitting && onPressed != null;

    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        // Color del texto e icono
        foregroundColor: strokeColor,
        // Color del borde
        side: BorderSide(
          color: isEnabled ? strokeColor : strokeColor.withOpacity(0.3),
          width: 2,
        ),
        disabledForegroundColor: strokeColor.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // Efecto visual al presionar sutil
        backgroundColor: Colors.transparent,
      ),
      child: isSubmitting
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(strokeColor),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
    );
  }
}