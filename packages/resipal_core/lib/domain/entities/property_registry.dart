import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';

class PropertyRegistry extends Equatable {
  final List<PropertyEntity> properties;

  const PropertyRegistry(this.properties);

  bool get hasDebt => properties.any((p) => p.hasDebt);

  int get totalOverdueFeeInCents => properties.fold(
    0,
    (sum, property) => sum + property.totalOverdueFeeInCents,
  );

  int get count => properties.length;

  List<PropertyEntity> get withDebt =>
      properties.where((p) => p.hasDebt).toList();

  @override
  List<Object?> get props => [properties];
}
