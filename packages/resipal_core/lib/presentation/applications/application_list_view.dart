import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/application_entity.dart';

import 'package:resipal_core/presentation/applications/application_card.dart';
import 'package:resipal_core/presentation/shared/texts/header_text.dart';

class ApplicationListView extends StatelessWidget {
  final List<ApplicationEntity> applications;
  const ApplicationListView(this.applications, {super.key});

  @override
  Widget build(BuildContext context) {
    if (applications.isEmpty) {
      return HeaderText.six('No hay solicitudes registrados ...');
    } else {
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: applications.length,
        itemBuilder: (ctx, index) {
          final application = applications[index];
          return ApplicationCard(application);
        },
      );
    }
  }
}
