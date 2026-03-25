import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/lib.dart';

class ValidateIdPage extends StatelessWidget {
  final InvitationEntity invitation;

  const ValidateIdPage({required this.invitation, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    GradientCard(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.badge_outlined, size: 48, color: Colors.white),
                              SizedBox(width: 12),
                              HeaderText.three('Validar identificación', color: Colors.white),
                            ],
                          ),
                          SizedBox(height: 24),
                          BodyText.large(
                            'Favor de validar que la identificación física coincida con la registrada.',
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              DefaultCard(
                child: Column(
                  children: [
                    DetailTile(icon: Icons.person_2, label: 'Nombre del invitado', value: invitation.visitor.name),
                    Divider(height: 1, color: colorScheme.outlineVariant),
                    DetailTile(icon: Icons.house_sharp, label: 'Visitando propiedad', value: invitation.property.name),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              SectionHeaderText(text: 'IDENTIFICACIÓN'),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: theme.colorScheme.surfaceVariant,
                  child: BucketImage(
                    bucket: 'visitors',
                    path: invitation.visitor.identificationPath!,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                child: SecondaryButton(
                  label: ('Identificación coincide').toUpperCase(),
                  borderColor: theme.colorScheme.tertiary,
                  onPressed: () => Go.to(SelectAccessDirectionPage(invitation: invitation)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: SecondaryButton(
                  label: ('Identificación no coincide').toUpperCase(),
                  onPressed: () =>
                      Go.to(AccessDeniedPage(title: invitation.visitor.name, reason: 'Identificación no coincide', onBackPressed: () => Go.multiBack(3),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
