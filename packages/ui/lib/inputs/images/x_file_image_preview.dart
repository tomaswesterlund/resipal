import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/inputs/images/base_image_preview.dart';
import 'package:ui/inputs/images/image_error_state.dart';

class XFileImagePreview extends StatelessWidget {
  final XFile xFile;
  final double height;
  final VoidCallback? onRemove;

  const XFileImagePreview({
    required this.xFile,
    this.height = 300,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseImagePreview(
      height: height,
      onRemove: onRemove,
      child: Image(
        image: kIsWeb ? NetworkImage(xFile.path) : FileImage(File(xFile.path)) as ImageProvider,
        fit: BoxFit.cover,
        width: double.infinity,
        height: height,
        errorBuilder: (context, error, stackTrace) => 
            const ImageErrorState(height: 120, text: 'Error al cargar archivo local'),
      ),
    );
  }
}