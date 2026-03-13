import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/visitors/visitor_list_view.dart';
import 'package:wester_kit/lib.dart';

class VisitorsPage extends StatelessWidget {
  final List<VisitorEntity> visitors;
  const VisitorsPage({required this.visitors, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Visitantes'),
      body: VisitorListView(visitors),
    );
  }
}