import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_core/domain/entities/id_entity.dart';

class EntityDropdownField<T extends IdEntity> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabel;
  final bool isRequired; // Indicator for required field
  final String? helpText; // Content for the info popup

  const EntityDropdownField({
    required this.label,
    required this.items,
    required this.onChanged,
    required this.itemLabel,
    this.value,
    this.isRequired = false,
    this.helpText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- The Custom Label Row ---
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.raleway(fontSize: 14.0, fontWeight: FontWeight.w600, color: const Color(0xFF1A4644)),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: GoogleFonts.raleway(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              if (helpText != null) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => _showHelpDialog(context),
                  child: Icon(Icons.help_outline_rounded, size: 16, color: Colors.grey.shade600),
                ),
              ],
            ],
          ),
        ),

        // --- The Dropdown Field ---
        DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
          style: GoogleFonts.raleway(fontSize: 16.0, color: Colors.black87),
          decoration: InputDecoration(
            // Removed labelText to use the external label style instead
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
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
              child: Text(itemLabel(entity), style: GoogleFonts.raleway(fontSize: 16.0)),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return items.map((T entity) {
              return Text(itemLabel(entity), overflow: TextOverflow.ellipsis);
            }).toList();
          },
        ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(label, style: GoogleFonts.raleway(fontWeight: FontWeight.bold)),
        content: Text(helpText!, style: GoogleFonts.raleway()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido', style: TextStyle(color: Color(0xFF1A4644))),
          ),
        ],
      ),
    );
  }
}
