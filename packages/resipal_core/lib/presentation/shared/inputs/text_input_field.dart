import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;
  final TextInputType keyboardType; // Added

  const TextInputField({
    required this.label,
    required this.hint,
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    this.keyboardType = TextInputType.text, // Default to text
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.raleway(fontSize: 14.0, fontWeight: FontWeight.w600, color: const Color(0xFF1A4644)),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: GoogleFonts.raleway(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context),
                  child: Icon(Icons.help_outline_rounded, size: 16, color: Colors.grey.shade600),
                ),
              ],
            ],
          ),
        ),

        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          keyboardType: keyboardType, // Using the parameter here
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

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(label, style: GoogleFonts.raleway(fontWeight: FontWeight.bold)),
        content: Text(helpText!, style: GoogleFonts.raleway()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido', style: TextStyle(color: Color(0xFF1A4644))),
          ),
        ],
      ),
    );
  }
}
