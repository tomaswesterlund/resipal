import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_admin/shared/app_colors.dart';

class PrimaryCtaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool canSubmit; // Added

  const PrimaryCtaButton({
    required this.label,
    required this.onPressed,
    this.canSubmit = false, // Default to false
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // Switches to grey when disabled
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: canSubmit ? 2 : 0,
        ),
        // Setting onPressed to null disables the button
        onPressed: canSubmit ? onPressed : null,
        child: Text(
          label,
          style: GoogleFonts.raleway(
            color: canSubmit ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
