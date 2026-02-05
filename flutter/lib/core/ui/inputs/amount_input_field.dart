import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountInputField extends StatelessWidget {
  final Function(double) onChanged;

  const AmountInputField({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      onChanged: (value) {
        try {
          final double? amount = double.tryParse(value);
          if (amount != null) {
            onChanged(amount);
          }
        } catch (e) {
          // Handle parsing error if necessary
        }
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        // Allow digits and only one decimal point
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      style: GoogleFonts.raleway(fontSize: 16.0, color: Colors.black87),
      decoration: InputDecoration(
        hintText: 'Cantidad',
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
