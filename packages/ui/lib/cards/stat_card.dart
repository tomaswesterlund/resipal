import 'package:flutter/material.dart';
import 'package:ui/lib.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatCard({required this.label, required this.value, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Eliminamos Spacer y MainAxisAlignment dinámico para evitar el error de redibujado
        children: [
          // 1. Header
          OverlineText(label.toUpperCase(), color: colorScheme.outline),

          const SizedBox(height: 12), // Espacio fijo más seguro
          // 2. Body (Icon + Value)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: colorScheme.primary, size: 32),
              const SizedBox(width: 12),
              // Usamos Flexible en lugar de Expanded + FittedBox para evitar conflictos de semántica
              Flexible(
                child: Text(
                  value,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: colorScheme.onSurface,
                    letterSpacing: -1,
                    fontFamily: 'NotoSansMono',
                  ),
                  overflow: TextOverflow.ellipsis, // Seguridad ante números gigantes
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
