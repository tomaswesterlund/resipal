import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;

  const TextInputField({required this.label, required this.hint, this.initialValue, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            label,
            style: GoogleFonts.raleway(fontSize: 14.0, fontWeight: FontWeight.w600, color: const Color(0xFF1A4644)),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          keyboardType: TextInputType.text,
          style: GoogleFonts.raleway(fontSize: 16.0, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.raleway(fontSize: 16.0, color: Colors.grey.shade500),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
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
        ),
      ],
    );
  }
}
