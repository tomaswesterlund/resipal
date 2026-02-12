import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/my_app_bar.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/community_entity.dart';
import 'package:resipal/presentation/users/user_onboarding/community/join_community/user_onboarding_join_community_page.dart';
import 'package:short_navigation/short_navigation.dart';

class UserOnboardingCommunityHome extends StatelessWidget {
  final List<CommunityEntity> communities;
  final Function(CommunityEntity) onCommunityJoined;
  const UserOnboardingCommunityHome({required this.communities, required this.onCommunityJoined, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: MyAppBar(title: 'Onboarding', automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Makes cards full width
          children: [
            SvgPicture.asset('assets/resipal_logo.svg', semanticsLabel: 'Resipal logo'),
            const SizedBox(height: 20),
            HeaderText.four('¡Casi terminamos!', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            BodyText.medium(
              'Solo falta configurar tu comunidad para empezar a usar Resipal.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            DefaultCard(
              onTap: () => Go.to(
                UserOnboardingJoinCommunityPage(communities: communities, onCommunityJoined: onCommunityJoined),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.group_add_outlined, size: 40, color: AppColors.primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderText.five('Unirse a una comunidad'),
                          BodyText.small('Soy residente y quiero unirme a mi comunidad.'),
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
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.add_business_outlined, size: 40, color: AppColors.primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderText.five('Crear nueva comunidad'),
                          BodyText.small(
                            'Soy administrador y quiero crear una nueva comunidad para un fraccionamiento o edificio.',
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
