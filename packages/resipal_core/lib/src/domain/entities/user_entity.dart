import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;

  final DateTime createdAt;
  final String createdBy;
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;

  const UserEntity({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
  });

  @override
  List<Object?> get props => [id, createdAt, createdBy, name, phoneNumber, emergencyPhoneNumber, email];
}
