class CreateApplicationDto {
  final String communityId;
  final String? userId;
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;
  final String status;
  final String message;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  CreateApplicationDto({
    required this.communityId,
    required this.userId,
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
      'community_id': communityId,
      'user_id': userId,
      'name': name,
      'phone_number': phoneNumber,
      'emergency_phone_number': emergencyPhoneNumber,
      'email': email,
      'status': status,
      'message': message,
      'is_admin': isAdmin,
      'is_resident': isResident,
      'is_security': isSecurity,
    };
  }
}
