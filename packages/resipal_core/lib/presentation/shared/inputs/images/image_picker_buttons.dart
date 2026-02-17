import 'package:flutter/material.dart';
import 'package:resipal_core/presentation/shared/inputs/images/picker_tile.dart';

class ImagePickerButtons extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  const ImagePickerButtons({super.key, required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PickerTile(icon: Icons.camera_alt_rounded, label: 'Cámara', onTap: onCamera),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PickerTile(icon: Icons.add_photo_alternate_outlined, label: 'Galería', onTap: onGallery),
        ),
      ],
    );
  }
}
