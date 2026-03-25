import 'package:flutter/material.dart';

class SuccessButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool canSubmit;
  final bool isSubmitting;
  final IconData? icon;

  const SuccessButton({
    required this.label,
    required this.onPressed,
    this.canSubmit = true,
    this.isSubmitting = false,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final bool isEnabled = canSubmit && !isSubmitting && onPressed != null;

    // We now rely on the Tertiary mapping in the theme
    final baseColor = colorScheme.tertiary; 
    final onColor = colorScheme.onTertiary;

    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        // Background logic: uses tertiary if enabled, otherwise a faded version
        backgroundColor: baseColor,
        foregroundColor: onColor,
        disabledBackgroundColor: baseColor.withOpacity(0.4),
        disabledForegroundColor: onColor.withOpacity(0.7),
        
        elevation: isEnabled ? 2 : 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        
        // This ensures the button grows to fill its container if needed
        minimumSize: const Size(120, 54), 
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isSubmitting
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(onColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20), 
                    const SizedBox(width: 10)
                  ],
                  Text(
                    label.toUpperCase(), // Professional admin-style
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: onColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}