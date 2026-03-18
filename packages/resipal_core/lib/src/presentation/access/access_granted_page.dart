// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/ui/buttons/secondary_button.dart';

class AccessGrantedPage extends StatelessWidget {
  final String title;
  final String reason; // e.g., "Entrada Registrada" or "Salida Registrada"

  const AccessGrantedPage({super.key, required this.title, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600], // Full screen green for "GO"
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              const Icon(Icons.check_circle_outline_rounded, size: 140, color: Colors.white),
              const SizedBox(height: 32),

              Text(
                reason.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              // Instructions
              const Text(
                'Puede permitir el acceso al visitante.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),

              const Spacer(),

              // Reset Button
              SizedBox(
                width: double.infinity,
                child: SecondaryButton(
                  borderColor: Colors.white,
                  label: 'LISTO',
                  onPressed: () => Navigator.popUntil(Go.context, (route) => route.isFirst),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
