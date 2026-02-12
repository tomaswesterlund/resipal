import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';

class LoadingView extends StatelessWidget {
  final String title;
  final String? description;
  const LoadingView({this.title = 'Cargando información...', this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pulsing Logo
          Opacity(opacity: 0.8, child: SvgPicture.asset('assets/resipal_logo.svg', height: 80)),
          const SizedBox(height: 40),
          // A sleek, thin progress bar
          const SizedBox(
            width: 120,
            child: LinearProgressIndicator(
              backgroundColor: AppColors.background,
              color: AppColors.secondary,
              minHeight: 2,
            ),
          ),
          const SizedBox(height: 24),
          HeaderText.four(title, textAlign: TextAlign.center),
          if (description != null) ...[
            const SizedBox(height: 8),
            BodyText.small(description!, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
