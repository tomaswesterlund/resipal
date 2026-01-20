import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/body_text.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Using a CircularProgressIndicator with your brand color
          const CircularProgressIndicator(
            color: Color(0xFF1A4644),
            strokeWidth: 3,
          ),
          const SizedBox(height: 24),
          
          // Using BodyText to inform the user
          BodyText.medium(
            'Cargando información...',
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}