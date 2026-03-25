import 'package:flutter/material.dart';
import 'package:ui/inputs/input_label.dart';

class EmailInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final String? helpText;
  final bool isReadonly;
  final String? errorText;

  const EmailInputField({
    required this.label,
    this.hint = "ejemplo@correo.com",
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.helpText,
    this.isReadonly = false,
    this.errorText, // Recibe el errorMessage de tu InputField<String>
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determinamos si hay un error para aplicar estilos visuales
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
          readOnly: isReadonly,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,

          // Usamos el errorText que viene por parámetro en lugar del validator interno
          decoration: InputDecoration(
            errorText: hasError ? errorText : null, // Muestra el error de tu Cubit
            hintText: hint,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: hasError ? colorScheme.error : (isReadonly ? colorScheme.outline : colorScheme.primary),
              size: 20,
            ),

            // Estilos del Input (Mantenemos tu diseño Premium)
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            filled: true,
            fillColor: isReadonly ? colorScheme.surfaceVariant.withOpacity(0.5) : colorScheme.surface,

            // Bordes Dinámicos
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: hasError ? colorScheme.error : colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: hasError ? colorScheme.error : (isReadonly ? colorScheme.outlineVariant : colorScheme.primary),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
          ),

          style: theme.textTheme.bodyMedium?.copyWith(
            color: isReadonly ? colorScheme.onSurfaceVariant.withOpacity(0.7) : colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
