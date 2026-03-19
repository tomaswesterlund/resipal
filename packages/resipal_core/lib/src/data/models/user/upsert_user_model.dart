class UpsertUserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;

  UpsertUserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'emergency_phone_number': emergencyPhoneNumber,
      'email': email,
    };
  }
}
