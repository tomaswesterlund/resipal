import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';

class ApplicationHeader extends StatelessWidget {
  final ApplicationEntity application;

  const ApplicationHeader(this.application, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GradientCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.document_scanner_outlined, color: Colors.white, size: 48),
              SizedBox(width: 12),
              HeaderText.two(application.name, color: Colors.white),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: colorScheme.outline),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverlineText('Comunidad', color: Colors.white),
                  BodyText.small(application.community.name, color: colorScheme.onPrimary.withOpacity(0.7)),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverlineText('Estatus', color: Colors.white),
                  SizedBox(height: 2),
                  StatusBadge(label: application.status.display, color: colorScheme.onPrimary),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
