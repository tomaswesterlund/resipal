import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/entities/payment_entity.dart';

class UserEntity {
  final String id;
  final DateTime createdAt;
  final String name;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String email;
  final List<MovementEntity> movements;
  final List<PaymentEntity> payments;

  UserEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.movements,
    required this.payments,
  });
}
