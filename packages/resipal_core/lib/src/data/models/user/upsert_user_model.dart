class UpsertUserModel {
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;

  UpsertUserModel({
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'phone_number': phoneNumber, 'emergency_phone_number': emergencyPhoneNumber, 'email': email};
  }
}
