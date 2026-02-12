import 'package:flutter/material.dart';
import 'package:resipal/core/ui/buttons/cta/primary_cta_button.dart';
import 'package:resipal/core/ui/texts/body_text.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/presentation/visitors/create_visitor/create_visitor_page.dart';
import 'package:short_navigation/short_navigation.dart';

class NoVisitorsFoundView extends StatelessWidget {
  const NoVisitorsFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderText.four('¡Oh no!', textAlign: TextAlign.center),
            BodyText.medium(
              'Aún no tienes visitantes registrados. Puedes agregar uno nuevo para generar una invitación.',
              color: Colors.grey.shade600,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            PrimaryCtaButton(
              icon: Icons.person,
              label: 'Registrar visitante',
              canSubmit: true,
              onPressed: () => Go.to(CreateVisitorPage()),
            ),
          ],
        ),
      ),
    );
  }
}
