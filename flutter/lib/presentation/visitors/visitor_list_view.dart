import 'package:flutter/material.dart';
import 'package:resipal/core/ui/cards/default_card.dart';
import 'package:resipal/core/ui/texts/header_text.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';
import 'package:resipal/presentation/visitors/visitor_card.dart';

class VisitorListView extends StatelessWidget {
  final List<VisitorEntity> visitors;
  const VisitorListView(this.visitors, {super.key});

  @override
  Widget build(BuildContext context) {
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
