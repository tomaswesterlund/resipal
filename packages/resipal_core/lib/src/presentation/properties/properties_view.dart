import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/presentation/contracts/no_active_contracts_found_view.dart';
import 'package:resipal_core/src/presentation/properties/empty_properties_view.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:wester_kit/ui/texts/header_text.dart';

class PropertiesView extends StatelessWidget {
  final List<PropertyEntity> properties;
  final bool showNoActiveContractInformation;
  final bool showRegisterProperty;

  const PropertiesView({
    required this.properties,
    required this.showNoActiveContractInformation,

    required this.showRegisterProperty,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (showNoActiveContractInformation) return NoActiveContractsFoundView();
    if (properties.isEmpty) return EmptyPropertiesView(showRegisterProperty: showRegisterProperty);

    return PropertyListView(properties);
  }
}
