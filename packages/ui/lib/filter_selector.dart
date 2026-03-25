import 'package:flutter/material.dart';
import 'package:ui/texts/header_text.dart';

class FilterSelectorItem<T> {
  final String label;
  final T value;

  const FilterSelectorItem({required this.label, required this.value});
}

class FilterSelector<T> extends StatelessWidget {
  final List<FilterSelectorItem<T>> options;
  final FilterSelectorItem<T> selectedValue;
  final ValueChanged<FilterSelectorItem<T>> onSelected;

  // Optional Color Overrides
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedTextColor;
  final Color? selectedTextColor;
  final Color? borderColor;

  const FilterSelector({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedTextColor,
    this.selectedTextColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Resolve Colors: priority to constructor, then theme defaults
    final bg = backgroundColor ?? colorScheme.surface;
    final selected = selectedColor ?? colorScheme.primary;
    final unselectedText = unselectedTextColor ?? colorScheme.onSurface;
    final selectedText = selectedTextColor ?? colorScheme.onPrimary;
    final border = borderColor ?? colorScheme.outlineVariant;

    return Container(
      height: 56,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: border),
      ),
      child: Row(
        children: options.map((option) {
          final isSelected = selectedValue == option;

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(option),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected ? selected : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: HeaderText.six(
                  option.label,
                  textAlign: TextAlign.center,
                  color: isSelected ? selectedText : unselectedText,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}