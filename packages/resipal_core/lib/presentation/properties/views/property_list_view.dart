import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/presentation/properties/views/no_properties_found_view.dart';
import 'package:resipal_core/presentation/properties/widgets/property_card.dart';

class PropertyListView extends StatelessWidget {
  final List<PropertyEntity> properties;
  const PropertyListView(this.properties, {super.key});

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) return NoPropertiesFoundView();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: properties.length,
      itemBuilder: (ctx, index) {
        final property = properties[index];
        return PropertyCard(property);
      },
    );
  }
}
