import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/formatters.dart';
import 'package:ui/inputs/input_label.dart';

class PhoneNumberInputField extends StatefulWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;
  final String? errorText;

  const PhoneNumberInputField({
    required this.label,
    this.hint = "55 1234 1234",
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    this.errorText,
    super.key,
  });

  @override
  State<PhoneNumberInputField> createState() => _PhoneNumberInputFieldState();
}

class _PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  final List<String> _dialCodes = ['+52', '+1'];
  late String _selectedDialCode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _selectedDialCode = _dialCodes.first;

    String initialText = "";
    if (widget.initialValue != null) {
      final String fullFormatted = PhoneFormatter.toDisplay(widget.initialValue!);
      initialText = fullFormatted.replaceFirst(_selectedDialCode, '').trim();
    }

    _controller = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleOnChanged(String value) {
    final cleanDigits = value.replaceAll(RegExp(r'\D'), '');
    widget.onChanged?.call('$_selectedDialCode$cleanDigits');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: InputLabel(label: widget.label, isRequired: widget.isRequired, helpText: widget.helpText),
        ),
        TextFormField(
          controller: _controller,
          onChanged: _handleOnChanged,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            _InputVisualFormatter(dialCode: _selectedDialCode),
          ],
          style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface, fontFamily: 'NotoSansMono'),
          decoration: InputDecoration(
            errorText: hasError ? widget.errorText : null,
            prefixIcon: _buildCountrySelector(colorScheme, theme, hasError),
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline, fontFamily: 'NotoSansMono'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            filled: true,
            fillColor: colorScheme.surface,

            // Bordes Estándar y Foco
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: hasError ? colorScheme.error : colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: hasError ? colorScheme.error : colorScheme.primary, width: 2),
            ),

            // Bordes de Error específicos
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountrySelector(ColorScheme colorScheme, ThemeData theme, bool hasError) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: hasError ? colorScheme.error : colorScheme.outlineVariant, width: 1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDialCode,
          icon: Icon(Icons.arrow_drop_down, size: 20, color: hasError ? colorScheme.error : colorScheme.primary),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: hasError ? colorScheme.error : colorScheme.primary,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() => _selectedDialCode = newValue);
              _handleOnChanged(_controller.text);
            }
          },
          items: _dialCodes.map((code) => DropdownMenuItem(value: code, child: Text(code))).toList(),
        ),
      ),
    );
  }
}

class _InputVisualFormatter extends TextInputFormatter {
  final String dialCode;
  _InputVisualFormatter({required this.dialCode});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    final String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final String fullNumber = '$dialCode$digits';
    final String formattedFull = PhoneFormatter.toDisplay(fullNumber);

    final String maskedLocal = formattedFull.replaceFirst(dialCode, '').trim();

    return TextEditingValue(
      text: maskedLocal,
      selection: TextSelection.collapsed(offset: maskedLocal.length),
    );
  }
}
