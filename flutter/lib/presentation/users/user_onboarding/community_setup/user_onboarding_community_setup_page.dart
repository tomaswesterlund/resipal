import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';

class UserOnboardingCommunitySetupPage extends StatelessWidget {
  const UserOnboardingCommunitySetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const HeaderText.two('Onboarding'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Makes cards full width
          children: [
            SvgPicture.asset(
              'assets/resipal_logo.svg',
              semanticsLabel: 'Resipal logo',
            ),
            const SizedBox(height: 20),
            HeaderText.four('¡Casi terminamos!', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            BodyText.medium(
              'Solo falta configurar tu comunidad para empezar a usar Resipal.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            DefaultCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.group_add_outlined,
                      size: 40,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderText.five('Unirse a una comunidad'),
                          BodyText.small(
                            'Soy residente y quiero unirme a mi comunidad.',
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            DefaultCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add_business_outlined,
                      size: 40,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderText.five('Crear nueva comunidad'),
                          BodyText.small(
                            'Soy administrador y quiero crear una nueva comunidad para un fraccionamiento y edificio.',
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
