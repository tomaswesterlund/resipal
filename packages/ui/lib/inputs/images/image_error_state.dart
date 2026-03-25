import 'package:flutter/material.dart';

class ImageErrorState extends StatelessWidget {
  final double height;
  final String text;

  const ImageErrorState({required this.height, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      color: theme.disabledColor.withOpacity(0.05),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, color: theme.disabledColor, size: 40),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(color: theme.disabledColor, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
