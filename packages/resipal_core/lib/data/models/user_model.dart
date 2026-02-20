class UserModel {
  final String id;
  final DateTime createdAt;
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      name: json['name'],
      phoneNumber: json['phone_number'],
      emergencyPhoneNumber: json['emergency_phone_number'],
      email: json['email'],
    );
  }
}
