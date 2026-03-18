import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/ui/buttons/secondary_button.dart';

class AccessDeniedPage extends StatelessWidget {
  final String title;
  final String reason;
  final VoidCallback? onBackPressed;

  const AccessDeniedPage({super.key, required this.title, required this.reason, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700], // Full screen red for "STOP"
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              const Icon(Icons.block_flipped, size: 140, color: Colors.white),
              const SizedBox(height: 32),

              const Text(
                'ACCESO DENEGADO',
                style: TextStyle(color: Colors.white, letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              // Reason Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: Text(
                  reason.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
                ),
              ),
              const SizedBox(height: 24),

              // Instructions
              const Text(
                'No permita el ingreso del visitante. El código no es válido para el acceso en este momento.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),

              const Spacer(),

              // Reset Button
              SizedBox(
                width: double.infinity,
                child: SecondaryButton(
                  borderColor: Colors.white,
                  label: 'VOLVER',
                  onPressed: onBackPressed ?? () => Navigator.popUntil(Go.context, (route) => route.isFirst),
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
