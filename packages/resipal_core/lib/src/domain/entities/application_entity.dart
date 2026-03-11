import 'package:resipal_core/lib.dart';

class ApplicationEntity {
  final String id;
  final CommunityRef community;
  final UserRef? user;
  final DateTime createdAt;
  final String createdBy;
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;
  final ApplicationStatus status;
  final String message;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  ApplicationEntity({
    required this.id,
    required this.community,
    required this.user,
    required this.createdAt,
    required this.createdBy,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.status,
    required this.message,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'community': community.toMap(),
      'user': user?.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'name': name,
      'phoneNumber': phoneNumber,
      'emergencyPhoneNumber': emergencyPhoneNumber,
      'email': email,
      'status': status.name, // Stores enum as String (e.g., "pending")
      'message': message,
      'isAdmin': isAdmin,
      'isResident': isResident,
      'isSecurity': isSecurity,
    };
  }
}
