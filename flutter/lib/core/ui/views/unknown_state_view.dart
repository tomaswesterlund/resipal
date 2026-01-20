import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';

class UnknownStateView extends StatelessWidget {
  const UnknownStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Using a subtle grey icon to represent an "empty" or "unknown" state
            Icon(
              Icons.help_outline_rounded,
              color: Colors.grey.shade400,
              size: 80,
            ),
            const SizedBox(height: 24),
            
            // Primary Message
            const HeaderText.three(
              'Estado Desconocido',
              color: Colors.black87,
            ),
            const SizedBox(height: 8),
            
            // Secondary Helper Text
            const BodyText.medium(
              'No pudimos determinar la información a mostrar. Por favor, intenta recargar la pantalla.',
              color: Colors.grey,
            ),
            
            const SizedBox(height: 32),
            
            // Action button to recover from the unknown state
            ElevatedButton.icon(
              onPressed: () {
                // Logic to reload or navigate back
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Recargar'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}