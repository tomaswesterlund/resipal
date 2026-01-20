import 'package:flutter/material.dart';

class PrimaryCtaButton extends StatelessWidget {
  const PrimaryCtaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(
          0xFFFF7235,
        ), // The exact orange from the image
        foregroundColor: Colors.white, // Text color
        elevation: 4, // Adjust for the depth of the shadow
        shadowColor: Colors.black.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Large rounded corners
        ),
      ),
      child: const Text(
        'REGISTRAR PAGO',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1, // Adds a premium look to all-caps text
        ),
      ),
    );
  }
}
