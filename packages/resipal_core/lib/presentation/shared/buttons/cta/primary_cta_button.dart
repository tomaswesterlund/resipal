import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_core/presentation/shared/colors/base_app_colors.dart';

class PrimaryCtaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool canSubmit;
  final bool isSubmitting;
  final IconData? icon;

  const PrimaryCtaButton({
    required this.label,
    required this.onPressed,
    this.canSubmit = false,
    this.isSubmitting = false,
    this.icon = Icons.home,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: canSubmit ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: BaseAppColors.primary, // Using your brand teal
        foregroundColor: Colors.white,
        disabledBackgroundColor: BaseAppColors.primary.withOpacity(
          0.3,
        ), // Softened teal for disabled state
        disabledForegroundColor: Colors.white.withOpacity(0.6),
        elevation: canSubmit ? 4 : 0, // Remove shadow when disabled
        shadowColor: Colors.black.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.raleway(
              // Using Raleway for consistency
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
