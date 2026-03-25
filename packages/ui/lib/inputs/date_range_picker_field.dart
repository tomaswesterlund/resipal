import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/inputs/input_label.dart';

class DateRangePickerField extends StatelessWidget {
  final String label;
  final DateTimeRange? selectedRange;
  final ValueChanged<DateTimeRange?> onRangeSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isRequired;
  final String? helpText;
  final String? errorMessage; // Nuevo: Parámetro de error

  const DateRangePickerField({
    required this.label,
    required this.onRangeSelected,
    this.selectedRange,
    this.firstDate,
    this.lastDate,
    this.isRequired = false,
    this.helpText,
    this.errorMessage, // Inicializado
    super.key,
  });

  Future<void> _pickDateRange(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
      initialDateRange: selectedRange,
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.primary,
              onPrimary: colorScheme.onPrimary,
              surface: colorScheme.surface,
              onSurface: colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onRangeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool hasError = errorMessage != null && errorMessage!.isNotEmpty;
    final dateFormat = DateFormat('dd/MM/yyyy');

    final displayString = selectedRange == null
        ? 'Seleccionar rango'
        : '${dateFormat.format(selectedRange!.start)} - ${dateFormat.format(selectedRange!.end)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: InputLabel(label: label, isRequired: isRequired, helpText: helpText),
        ),
        InkWell(
          onTap: () => _pickDateRange(context),
          borderRadius: BorderRadius.circular(20.0),
          child: InputDecorator(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.calendar_today_rounded,
                size: 20,
                // El icono también reacciona al error
                color: hasError ? colorScheme.error : colorScheme.primary,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              // Bordes que reaccionan al estado de error
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: hasError ? colorScheme.error : colorScheme.outlineVariant,
                  width: hasError ? 2 : 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: hasError ? colorScheme.error : colorScheme.primary, width: 2),
              ),
              filled: true,
              fillColor: colorScheme.surface,
              // Ocultamos el error nativo para usar nuestro custom Text abajo
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              errorText: hasError ? '' : null,
            ),
            child: Text(
              displayString,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16.0,
                color: selectedRange == null
                    ? (hasError ? colorScheme.error.withOpacity(0.6) : colorScheme.outline)
                    : colorScheme.onSurface,
                fontFamily: selectedRange == null ? null : 'NotoSansMono',
              ),
            ),
          ),
        ),

        // --- Mensaje de Error ---
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
