import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_core/domain/entities/id_entity.dart';

class EntityDropdownField<T extends IdEntity> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabel; // Function to get the display name

  const EntityDropdownField({
    required this.label,
    required this.items,
    required this.onChanged,
    required this.itemLabel,
    this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
      style: GoogleFonts.raleway(fontSize: 16.0, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label, // Using labelText for the floating effect
        labelStyle: GoogleFonts.raleway(
          fontSize: 16.0,
          color: Colors.grey.shade500,
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
        filled: true,
        fillColor: Colors.white,
      ),
      items: items.map((T entity) {
        return DropdownMenuItem<T>(
          value: entity,
          child: Text(
            itemLabel(entity),
            style: GoogleFonts.raleway(fontSize: 16.0),
          ),
        );
      }).toList(),
      // Custom selected item builder to ensure the text fits the field
      selectedItemBuilder: (BuildContext context) {
        return items.map((T entity) {
          return Text(itemLabel(entity), overflow: TextOverflow.ellipsis);
        }).toList();
      },
    );
  }
}
