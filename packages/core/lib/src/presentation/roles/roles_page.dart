import 'package:core/src/presentation/roles/roles_view.dart';
import 'package:flutter/material.dart';
import 'package:ui/lib.dart';
import 'package:ui/my_app_bar.dart';

class RolesPage extends StatelessWidget {
  const RolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const MyAppBar(title: 'Definición de Roles'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: RolesView(),
      ),
    );
  }

  
}