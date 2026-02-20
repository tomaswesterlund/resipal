import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/property_registry.dart';
import 'package:resipal_core/presentation/properties/views/no_properties_found_view.dart';
import 'package:resipal_core/presentation/properties/views/property_list_view.dart';

class AdminPropertiesView extends StatelessWidget {
  final PropertyRegistry registry;
  const AdminPropertiesView(this.registry, {super.key});

  @override
  Widget build(BuildContext context) {
    if (registry.properties.isEmpty) {
      return NoPropertiesFoundView();
    }

    return Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: PropertyListView(registry.properties));
  }
}
