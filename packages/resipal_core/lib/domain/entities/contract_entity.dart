import 'package:resipal_core/domain/entities/id_entity.dart';

class ContractEntity extends IdEntity {
  final String name;
  final DateTime createdAt;
  final String period;
  final int amountInCents;
  final String? description;

  ContractEntity({
    required super.id,
    required this.name,
    required this.createdAt,
    required this.period,
    required this.amountInCents,
    required this.description,
    // required this.fees
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'period': period,
      'amountInCents': amountInCents,
      'description': description,
    };
  }
}
