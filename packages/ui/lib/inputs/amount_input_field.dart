import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/inputs/input_label.dart';
import 'package:ui/texts/body_text.dart';

class AmountInputField extends StatelessWidget {
  final String label;
  final String hint;
  final double? initialValue;
  final Function(double) onChanged;
  final bool isRequired;
  final String? helpText;
  final bool readOnly;
  final String currencySymbol;

  const AmountInputField({
    super.key,
    required this.label,
    required this.onChanged,
    this.hint = '0.00',
    this.initialValue,
    this.isRequired = false,
    this.helpText,
    this.readOnly = false,
    this.currencySymbol = '\$',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: InputLabel(label: label, isRequired: isRequired, helpText: helpText),
        ),

        // --- Input Field ---
        TextFormField(
          initialValue: initialValue?.toStringAsFixed(2),
          readOnly: readOnly,
          onChanged: (value) {
            final double? amount = double.tryParse(value);
            if (amount != null) {
              onChanged(amount);
            }
          },
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))],
          style: textTheme.bodyLarge?.copyWith(
            color: readOnly ? colorScheme.outline : colorScheme.onSurface,
            fontFamily: 'NotoSansMono', // Keeping your numeric font preference
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                currencySymbol,
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.outline),
              ),
            ),
            hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            filled: true,
            // Uses a standard surface color or a light variant when read-only
            fillColor: readOnly ? colorScheme.surfaceVariant : colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: readOnly ? colorScheme.outlineVariant : colorScheme.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(label, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        content: Text(helpText!, style: theme.textTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Entendido',
              style: theme.textTheme.labelLarge?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
