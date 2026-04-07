import 'package:flutter/material.dart';
import 'package:ui/inputs/input_label.dart';
import 'package:ui/texts/body_text.dart';
import 'package:ui/texts/header_text.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? errorText;

  const TextInputField({
    required this.label,
    required this.hint,
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.suffixIcon,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: InputLabel(label: label, isRequired: isRequired, helpText: helpText),
        ),

        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: obscureText ? 1 : maxLines,
          readOnly: readOnly,
          obscureText: obscureText,
          style: theme.textTheme.bodyMedium?.copyWith(color: readOnly ? colorScheme.outline : colorScheme.onSurface),
          decoration: InputDecoration(
            errorText: hasError ? errorText : null,
            hintText: hint,
            prefixIcon: prefixIcon != null ? _buildPrefixIcon(colorScheme, hasError) : null,
            suffixIcon: suffixIcon,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),

            // Lógica de llenado (Readonly vs Normal)
            filled: true,
            fillColor: readOnly ? colorScheme.surfaceVariant.withOpacity(0.5) : colorScheme.surface,

            // Borde estándar
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: hasError ? colorScheme.error : colorScheme.outlineVariant),
            ),

            // Borde cuando está enfocado
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: hasError ? colorScheme.error : (readOnly ? colorScheme.outlineVariant : colorScheme.primary),
                width: 2,
              ),
            ),

            // Bordes específicos de error (para cuando el validator de Flutter o errorText están activos)
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

  /// Ajusta el color del icono de prefijo si es un Icon widget basado en el estado
  Widget? _buildPrefixIcon(ColorScheme colorScheme, bool hasError) {
    if (prefixIcon is Icon) {
      final icon = prefixIcon as Icon;
      return Icon(
        icon.icon,
        size: icon.size ?? 20,
        color: hasError ? colorScheme.error : (readOnly ? colorScheme.outline : colorScheme.primary),
      );
    }
    return prefixIcon;
  }

  void _showHelpDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: HeaderText.three(label),
        content: BodyText.medium(helpText!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: HeaderText.six('Entendido', color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
