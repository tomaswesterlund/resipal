import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final bool enabled;
  final Function(String)? onChanged;

  const EmailInputField({
    required this.label,
    this.hint = "example@email.com",
    this.initialValue,
    this.enabled = true,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            label,
            style: GoogleFonts.raleway(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A4644),
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          enabled: enabled,
          onChanged: onChanged,
          // 1. Optimized for Email (shows @ and . on main keyboard)
          keyboardType: TextInputType.emailAddress,
          // 2. Disables auto-correct (it's annoying for unique email handles)
          autocorrect: false,
          // 3. Built-in validation logic
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value);
            return emailValid ? null : 'Enter a valid email address';
          },
          style: GoogleFonts.raleway(fontSize: 16.0, color: Colors.black87),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF1A4644)),
            hintText: hint,
            hintStyle: GoogleFonts.raleway(
              fontSize: 16.0,
              color: Colors.grey.shade400,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}