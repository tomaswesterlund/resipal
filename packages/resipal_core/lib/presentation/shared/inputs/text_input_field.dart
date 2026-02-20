import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefixIcon; // Added
  final bool readOnly; // Added

  const TextInputField({
    required this.label,
    required this.hint,
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixIcon, // Added
    this.readOnly = false, // Added
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Row
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.raleway(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A4644),
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: GoogleFonts.raleway(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context),
                  child: Icon(
                    Icons.help_outline_rounded,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ],
          ),
        ),

        // Input Field
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly, // Apply readOnly property
          style: GoogleFonts.raleway(
            fontSize: 16.0, 
            color: readOnly ? Colors.grey.shade600 : Colors.black87, // Dim text if readOnly
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon, // Apply prefixIcon
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
              borderSide: BorderSide(
                color: readOnly ? Colors.grey.shade300 : const Color(0xFF1A4644), 
                width: 2,
              ),
            ),
            filled: true,
            // Light grey background if readOnly to signify it is disabled
            fillColor: readOnly ? Colors.grey.shade100 : Colors.white,
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
        title: Text(
          label,
          style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
        ),
        content: Text(helpText!, style: GoogleFonts.raleway()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Entendido',
              style: TextStyle(
                color: Color(0xFF1A4644), 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}