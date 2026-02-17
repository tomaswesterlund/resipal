import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/visitor_entity.dart';
import 'package:resipal_core/presentation/shared/texts/body_text.dart';
import 'package:resipal_core/presentation/visitors/widgets/visitor_card.dart';

class VisitorListView extends StatelessWidget {
  final List<VisitorEntity> visitors;
  const VisitorListView(this.visitors, {super.key});

  @override
  Widget build(BuildContext context) {
    if (visitors.isEmpty) {
      return Center(
        child: BodyText.medium(
          'No se encontraron visitantes registrados.',
          color: Colors.grey.shade600,
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: visitors.length,
      itemBuilder: (ctx, index) {
        final visitor = visitors[index];
        return VisitorCard(visitor);
      },
    );
  }
}
