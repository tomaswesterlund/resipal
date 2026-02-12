// import 'package:resipal/domain/entities/id_entity.dart';
// import 'package:resipal/domain/entities/maintenance_contract_entity.dart';
// import 'package:resipal/domain/refs/community_ref.dart';
// import 'package:resipal/domain/refs/user_ref.dart';

// class UserPropertyEntity extends IdEntity {
//   final CommunityRef community;
//   final UserRef owner;
//   final DateTime createdAt;
//   final String name;
//   final String? description;
//   final MaintenanceContractEntity contract;

//   bool get hasDebt => totalOverdueFeeInCents > 0;
//   int get totalOverdueFeeInCents => contract.totalOverdueFeeInCents;

//   UserPropertyEntity({
//     required super.id,
//     required this.community,
//     required this.owner,
//     required this.createdAt,
//     required this.name,
//     required this.description,
//     required this.contract,
//   });
// }
