import 'package:flutter/material.dart';
import 'custom_button.dart';

class PrimaryCtaButton extends CustomButton {
  PrimaryCtaButton({required super.label, super.onPressed, super.canSubmit = true, super.isLoading = false, super.key})
    : super(backgroundColor: Color(0xFF1A4644));
}
