import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';

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