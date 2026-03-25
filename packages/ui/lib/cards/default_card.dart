// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final double elevation;
  final ShapeBorder? shape; // Nueva propiedad opcional

  const DefaultCard({
    super.key,
    required this.child,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
    this.onTap,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Definimos la forma por defecto (Radius 20) si no se provee una
    final effectiveShape = shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: elevation,
        shape: effectiveShape,
        clipBehavior: Clip.antiAlias, // Asegura que el contenido respete la forma
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            // Si hay un shape personalizado, podrías necesitar ajustar este borde,
            // pero mantenemos tu diseño de Resipal con outlineVariant.
            border: Border.all(color: colorScheme.outlineVariant),
            // Sincronizamos el radius del container con el del Card por defecto
            borderRadius: shape == null ? BorderRadius.circular(20) : null,
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
