import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/entities/invitation_entity.dart';
import 'package:resipal_core/domain/entities/payment_ledger_entity.dart';
import 'package:resipal_core/domain/entities/property_entity.dart';
import 'package:resipal_core/domain/entities/property_registry.dart';
import 'package:resipal_core/domain/entities/user_membership.dart';

class UserEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final String name;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String email;
  final UserMembership membership;
  final List<InvitationEntity> invitations;
  final PaymentLedgerEntity ledger;
  final PropertyRegistry registry;

  List<InvitationEntity> get activeInvitations =>
      invitations.where((e) => e.canEnter).toList();


  const UserEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.membership,
    required this.invitations,
    required this.ledger,
    required this.registry,
  });

  @override
  List<Object?> get props => [
    id,
    createdAt,
    name,
    phoneNumber,
    emergencyPhoneNumber,
    email,
    membership,
    invitations,
    ledger,
    registry,
  ];
}
