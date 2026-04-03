import 'package:flutter/material.dart';
import 'package:ui/lib.dart';

class EntityDropdownField<T> extends StatelessWidget {
  final String label;
  final T? initialValue;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final String? helpText;
  final bool readOnly;
  final String? errorMessage;

  const EntityDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.initialValue,
    this.isRequired = false,
    this.helpText,
    this.readOnly = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool hasError = errorMessage != null && errorMessage!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: InputLabel(label: label, isRequired: isRequired, helpText: helpText),
        ),

        DropdownButtonFormField<T>(
          initialValue: initialValue,
          onChanged: readOnly ? null : onChanged,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: readOnly ? colorScheme.outlineVariant : (hasError ? colorScheme.error : colorScheme.outline),
          ),
          dropdownColor: colorScheme.surface,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: readOnly ? colorScheme.onSurface.withOpacity(0.6) : colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            filled: true,
            fillColor: readOnly ? colorScheme.surfaceVariant.withOpacity(0.3) : colorScheme.surface,

            // Bordes estándar
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: hasError ? colorScheme.error : colorScheme.outlineVariant,
                width: hasError ? 2 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: readOnly ? colorScheme.outlineVariant : (hasError ? colorScheme.error : colorScheme.primary),
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),

            // Configuración del texto de error nativo
            // Lo ocultamos aquí para manejarlo manualmente abajo y tener control total del padding
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            errorText: hasError ? '' : null,
          ),
          items: items.map((T item) {
            return DropdownMenuItem<T>(value: item, child: Text(itemLabelBuilder(item)));
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return items.map((T item) {
              return Text(
                itemLabelBuilder(item),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: readOnly ? colorScheme.onSurface.withOpacity(0.8) : colorScheme.onSurface),
              );
            }).toList();
          },
        ),

        // --- Mensaje de Error (Custom UI) ---
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Text(
              errorMessage!,
              style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.error, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }
}
