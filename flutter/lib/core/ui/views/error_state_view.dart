import 'package:flutter/material.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/core/ui/texts/body_text.dart';

class ErrorStateView extends StatelessWidget {
  final String? errorMessage;
  final Object? exception;

  const ErrorStateView({super.key, this.errorMessage, this.exception});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 64),
            const SizedBox(height: 16),

            // Main user-friendly message
            HeaderText.three(errorMessage ?? 'Algo salió mal!', color: Colors.black87),

            // Technical exception details (only shown if exception is not null)
            if (exception != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                child: BodyText.tiny(exception.toString(), color: Colors.grey.shade700),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
