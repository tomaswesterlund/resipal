import 'package:flutter/material.dart';

class CheckboxField extends StatelessWidget {
  final String label;
  final String? helpText;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckboxField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.helpText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onChanged(!value),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            child: Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: IgnorePointer(
                    child: Checkbox(
                      value: value,
                      onChanged: (value) {},
                      activeColor: colorScheme.primary,
                      checkColor: colorScheme.onPrimary,
                      side: BorderSide(color: colorScheme.outline, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Help Text implementation matching TextInputField style
        if (helpText != null)
          Padding(
            padding: const EdgeInsets.only(left: 44.0, top: 2.0, bottom: 4.0),
            child: Text(
              helpText!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.outline,
                height: 1.2,
              ),
            ),
          ),
      ],
    );
  }
}