import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius; // Nuevo parámetro

  const GradientCard({
    required this.child, 
    this.padding, 
    this.borderRadius = 20.0, // Valor por defecto
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.primary, 
            colorScheme.primary.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.2), 
            blurRadius: 10, 
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(24.0), 
        child: child,
      ),
    );
  }
}