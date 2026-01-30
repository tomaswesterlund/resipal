// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  final Widget child;
  final double padding;
  final VoidCallback? onTap;

  const DefaultCard({
    super.key,
    required this.child,
    this.padding = 0.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(padding),
          child: child,
        ),
      ),
    );
  }
}
