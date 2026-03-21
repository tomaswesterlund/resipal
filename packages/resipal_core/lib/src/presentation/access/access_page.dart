import 'package:flutter/material.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class AccessPage extends StatelessWidget {
  final AccessRegistry registry;
  const AccessPage(this.registry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Accesos'),
      body: AccessOverview(accessRegistry: registry),
    );
  }
}