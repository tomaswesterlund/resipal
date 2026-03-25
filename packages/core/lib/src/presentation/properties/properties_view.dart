import 'package:flutter/material.dart';

import 'package:core/lib.dart';

class PropertiesView extends StatelessWidget {
  final PropertyRegistry registry;
  final bool showNoActiveContractInformation;
  final bool showRegisterProperty;

  const PropertiesView({
    required this.registry,
    required this.showNoActiveContractInformation,

    required this.showRegisterProperty,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (showNoActiveContractInformation) return NoActiveContractsFoundView();
    if (registry.properties.isEmpty) return EmptyPropertiesView(showRegisterProperty: showRegisterProperty);

    return PropertyListView(registry);
  }
}
