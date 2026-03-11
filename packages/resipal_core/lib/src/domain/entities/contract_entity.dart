import 'package:equatable/equatable.dart';
import 'package:resipal_core/src/domain/entities/id_entity.dart';

class ContractEntity extends IdEntity implements Equatable {
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

  @override
  List<Object?> get props => [
    id, // From IdEntity
    name,
    createdAt,
    period,
    amountInCents,
    description,
  ];

  @override
  bool get stringify => true;
}
