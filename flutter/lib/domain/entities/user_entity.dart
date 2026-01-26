import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/entities/property_entity.dart';

class UserEntity {
  final String id;
  final DateTime createdAt;
  final String name;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String email;
  final List<InvitationEntity> invitations;
  final List<MovementEntity> movements;
  final List<PaymentEntity> payments;
  final List<PropertyEntity> properties;

  List<InvitationEntity> get activeInvitations =>
      invitations.where((e) => e.isActive).toList();

  UserEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.invitations,
    required this.movements,
    required this.payments,
    required this.properties
  });
}
