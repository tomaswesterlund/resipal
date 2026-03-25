import 'package:flutter/material.dart';
import 'package:ui/inputs/images/picker_tile.dart';

class ImagePickerButtons extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final String? errorText; // Nuevo: Propiedad de error

  const ImagePickerButtons({
    super.key, 
    required this.onCamera, 
    required this.onGallery,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _StyledPickerTile(
                icon: Icons.camera_alt_rounded,
                label: 'Cámara',
                onTap: onCamera,
                hasError: hasError,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StyledPickerTile(
                icon: Icons.add_photo_alternate_outlined,
                label: 'Galería',
                onTap: onGallery,
                hasError: hasError,
              ),
            ),
          ],
        ),
        
        // Mensaje de error debajo de los botones
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Text(
              errorText!,
              style: TextStyle(
                color: colorScheme.error,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

/// Helper para aplicar el borde de error al PickerTile existente
class _StyledPickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool hasError;

  const _StyledPickerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hasError ? colorScheme.error : Colors.transparent,
          width: hasError ? 2.0 : 0.0,
        ),
      ),
      child: PickerTile(
        icon: icon,
        label: label,
        onTap: onTap,
      ),
    );
  }
}