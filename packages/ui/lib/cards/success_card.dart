import 'package:flutter/material.dart';

class SuccessCard extends StatelessWidget {
  final Widget child;
  final bool showIcon;

  const SuccessCard({required this.child, this.showIcon = false, super.key});

  @override
  Widget build(BuildContext context) {
    // Using a soft green palette that typically complements primary UI schemes
    final successColor = Colors.green.shade600;
    final backgroundColor = Colors.green.shade50;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20), // Matching your DefaultCard radius
        border: Border.all(color: successColor.withOpacity(0.2), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Optional subtle accent bar on the left
            Positioned(left: 0, top: 0, bottom: 0, child: Container(width: 4, color: successColor)),
            Padding(
              padding: const EdgeInsets.only(left: 4.0), // Room for the accent bar
              child: child,
            ),
            if (showIcon)
              Positioned(
                right: -10,
                bottom: -10,
                child: Icon(Icons.check_circle, size: 80, color: successColor.withOpacity(0.05)),
              ),
          ],
        ),
      ),
    );
  }
}
