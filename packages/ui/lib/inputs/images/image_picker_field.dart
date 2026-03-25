import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/inputs/images/image_picker_buttons.dart';
import 'package:ui/inputs/images/x_file_image_preview.dart';

class ImagePickerField extends StatelessWidget {
  final XFile? xFile;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback? onRemove; // Useful for resetting the form

  const ImagePickerField({
    required this.xFile,
    required this.onCamera,
    required this.onGallery,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: xFile != null
          ? XFileImagePreview(
              key: const ValueKey('preview'),
              xFile: xFile!,
              onRemove: onRemove, // Pass a way to delete the photo
            )
          : ImagePickerButtons(
              key: const ValueKey('picker'),
              onCamera: onCamera,
              onGallery: onGallery,
            ),
    );
  }
}