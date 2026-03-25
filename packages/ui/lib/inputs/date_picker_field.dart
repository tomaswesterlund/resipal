import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/texts/body_text.dart';
import 'package:ui/texts/header_text.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isRequired;
  final String? helpText;
  final Widget? prefixIcon;
  final String? errorMessage; // Nuevo: Parámetro de error

  // Optional Overrides
  final Color? primaryColor;
  final Color? borderColor;

  const DatePickerField({
    required this.label,
    required this.onDateChanged,
    this.selectedDate,
    this.firstDate,
    this.lastDate,
    this.isRequired = false,
    this.helpText,
    this.prefixIcon,
    this.primaryColor,
    this.borderColor,
    this.errorMessage, // Inicializado
    super.key,
  });

  Future<void> _pickDate(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: colorScheme.copyWith(
              primary: primaryColor ?? colorScheme.primary,
              onPrimary: colorScheme.onPrimary,
              onSurface: colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bool hasError = errorMessage != null && errorMessage!.isNotEmpty;
    
    final dateFormat = DateFormat('dd/MM/yyyy');
    final displayString = selectedDate == null ? 'Seleccionar fecha' : dateFormat.format(selectedDate!);

    // Resolve Colors considerando el estado de error
    final activePrimary = hasError ? colorScheme.error : (primaryColor ?? colorScheme.primary);
    final activeBorder = hasError ? colorScheme.error : (borderColor ?? colorScheme.outlineVariant);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Label Row ---
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderText.six(label, color: colorScheme.onSurface),
              if (isRequired) 
                BodyText.small(' *', color: colorScheme.error, fontWeight: FontWeight.bold),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context),
                  child: Icon(Icons.help_outline_rounded, size: 16, color: colorScheme.outline),
                ),
              ],
            ],
          ),
        ),

        // --- Input Decorator ---
        InkWell(
          onTap: () => _pickDate(context),
          borderRadius: BorderRadius.circular(20.0),
          child: InputDecorator(
            decoration: InputDecoration(
              prefixIcon: prefixIcon ?? Icon(Icons.calendar_month_rounded, size: 20, color: activePrimary),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: activeBorder,
                  width: hasError ? 2 : 1, // Grosor mayor si hay error
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: activePrimary, width: 2),
              ),
              filled: true,
              fillColor: colorScheme.surface,
              // Ocultamos error nativo para usar nuestro custom Text abajo
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              errorText: hasError ? '' : null,
            ),
            child: Text(
              displayString,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16.0,
                color: selectedDate == null 
                    ? (hasError ? colorScheme.error.withOpacity(0.6) : colorScheme.outline) 
                    : colorScheme.onSurface,
                fontFamily: selectedDate == null ? null : 'NotoSansMono',
              ),
            ),
          ),
        ),

        // --- Mensaje de Error (Estilo Wester Kit) ---
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Text(
              errorMessage!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
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
            child: HeaderText.six('Entendido', color: primaryColor ?? colorScheme.primary),
          ),
        ],
      ),
    );
  }
}