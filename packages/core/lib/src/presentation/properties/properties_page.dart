import 'package:flutter/material.dart';
import 'package:core/lib.dart';
import 'package:core/src/presentation/properties/property_list_view.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ui/my_app_bar.dart';

class PropertiesPage extends StatelessWidget {
  final PropertyRegistry registry;
  const PropertiesPage(this.registry, {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: MyAppBar(
        title: 'Propiedades',
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () => Go.to(RegisterPropertyPage()))],
      ),

      body: PropertyListView(registry),
    );
  }
}
