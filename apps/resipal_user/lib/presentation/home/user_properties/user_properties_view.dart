import 'package:flutter/material.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/presentation/properties/views/no_properties_found_view.dart';
import 'package:resipal_core/presentation/properties/views/property_list_view.dart';
import 'package:resipal_core/presentation/shared/cards/shimmer_card.dart';

class UserPropertiesView extends StatelessWidget {
  final UserEntity user;
  const UserPropertiesView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    if (user.propertyRegistery.properties.isEmpty) {
      return NoPropertiesFoundView();
    } else {
      return PropertyListView(user.propertyRegistery.properties);
    }
  }
}

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ShimmerCard(), ShimmerCard(), ShimmerCard()],
    );
  }
}

class _Loaded extends StatelessWidget {
  final List<PropertyEntity> properties;
  const _Loaded(this.properties, {super.key});

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return NoPropertiesFoundView();
    } else {
      return PropertyListView(properties);
    }
  }
}
