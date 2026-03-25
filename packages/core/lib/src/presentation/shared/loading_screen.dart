import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/texts/header_text.dart';
import 'package:ui/views/loading_view.dart';

class LoadingScreen extends StatelessWidget {
  final LogoColor logoColor;
  final String title;
  final String subtitle;
  final String loadingTitle;
  final String? loadingDescription;

  const LoadingScreen({
    super.key,

    required this.title,
    required this.subtitle,
    this.logoColor = LogoColor.green,
    this.loadingTitle = 'Cargando ...',
    this.loadingDescription,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResipalLogo(color: logoColor),
            const SizedBox(height: 12),
            HeaderText.giga(title, color: colorScheme.inverseSurface),
            const SizedBox(height: 8),
            HeaderText.three(subtitle, color: colorScheme.inverseSurface),
            const SizedBox(height: 32), // Added some extra breathing room
            LoadingView(title: loadingTitle, description: loadingDescription),
          ],
        ),
      ),
    );
  }
}
