import 'package:equatable/equatable.dart';
import 'package:resipal_core/src/domain/entities/property_entity.dart';

class PropertyRegistry extends Equatable {
  final List<PropertyEntity> properties;

  const PropertyRegistry(this.properties);

  bool get hasDebt => properties.any((p) => p.hasDebt);
  bool get hasOverdueFees => properties.any((p) => p.hasOverdueFees);
  bool get hasPendingFees => properties.any((p) => p.hasPendingFees);

  int get totalDebtAmountInCents => properties.fold(0, (sum, property) => sum + property.totalDebtAmountInCents);
  int get totalPaidAmountInCents => properties.fold(0, (sum, property) => sum + property.totalPaidAmountInCents);

  int get count => properties.length;

  List<PropertyEntity> get withDebt => properties.where((p) => p.hasDebt).toList();
  List<PropertyEntity> get withOverduesFees => properties.where((p) => p.hasOverdueFees).toList();
  List<PropertyEntity> get withPendingFees => properties.where((p) => p.hasPendingFees).toList();

  @override
  List<Object?> get props => [properties];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'properties': properties.map((p) => p.toMap()).toList()};
  }
}
