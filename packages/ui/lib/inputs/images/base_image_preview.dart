import 'package:flutter/material.dart';

class BaseImagePreview extends StatelessWidget {
  final Widget child;
  final double height;
  final VoidCallback? onRemove;

  const BaseImagePreview({required this.child, required this.height, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
          ),
          child: child,
        ),
        if (onRemove != null)
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                child: const Icon(Icons.close_rounded, size: 20, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

