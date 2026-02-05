import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final Function(String)? onChanged;

  const TextInputField({
    required this.label,
    this.initialValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      style: GoogleFonts.raleway(fontSize: 16.0, color: Colors.black87),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: GoogleFonts.raleway(
          fontSize: 16.0,
          color: Colors.grey.shade500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 18.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Color(0xFF1A4644), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
