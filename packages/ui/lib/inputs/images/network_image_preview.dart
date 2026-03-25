import 'package:flutter/material.dart';
import 'package:ui/inputs/images/base_image_preview.dart';
import 'package:ui/inputs/images/image_error_state.dart';

class NetworkImagePreview extends StatelessWidget {
  final String url;
  final double height;
  final String errorText;
  final VoidCallback? onRemove;

  const NetworkImagePreview({
    required this.url,
    this.height = 300,
    this.errorText = 'No se pudo cargar la imagen',
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseImagePreview(
      height: height,
      onRemove: onRemove,
      child: url.isEmpty
          ? ImageErrorState(height: 120, text: errorText)
          : Image.network(
              url,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: height,
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
              errorBuilder: (context, error, stackTrace) => ImageErrorState(height: 120, text: errorText),
            ),
    );
  }
}
