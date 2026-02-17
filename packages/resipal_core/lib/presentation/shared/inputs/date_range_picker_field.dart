import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Add intl to your pubspec.yaml

class DateRangePickerField extends StatelessWidget {
  final String label;
  final DateTimeRange? selectedRange;
  final ValueChanged<DateTimeRange?> onRangeSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateRangePickerField({
    required this.label,
    required this.onRangeSelected,
    this.selectedRange,
    this.firstDate,
    this.lastDate,
    super.key,
  });

  Future<void> _pickDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
      initialDateRange: selectedRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1A4644), // Your brand teal
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textTheme: GoogleFonts.ralewayTextTheme(),
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
    final dateFormat = DateFormat('dd/MM/yyyy');
    final displayString = selectedRange == null
        ? label
        : '${dateFormat.format(selectedRange!.start)} - ${dateFormat.format(selectedRange!.end)}';

    return InkWell(
      onTap: () => _pickDateRange(context),
      borderRadius: BorderRadius.circular(20.0),
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.calendar_today_rounded, size: 20),
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
          filled: true,
          fillColor: Colors.white,
        ),
        child: Text(
          displayString,
          style: GoogleFonts.raleway(
            fontSize: 16.0,
            color: selectedRange == null ? Colors.grey.shade500 : Colors.black87,
          ),
        ),
      ),
    );
  }
}