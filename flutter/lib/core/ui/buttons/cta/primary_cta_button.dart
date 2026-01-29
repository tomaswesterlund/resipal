import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal/core/ui/app_colors.dart';

class PrimaryCtaButton extends StatelessWidget {
  final String label;
  final bool canSubmit;
  final VoidCallback onPressed;

  const PrimaryCtaButton({
    required this.label,
    required this.canSubmit,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: canSubmit ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, // Using your brand teal
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.primary.withOpacity(0.3), // Softened teal for disabled state
        disabledForegroundColor: Colors.white.withOpacity(0.6),
        elevation: canSubmit ? 4 : 0, // Remove shadow when disabled
        shadowColor: Colors.black.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.raleway( // Using Raleway for consistency
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}