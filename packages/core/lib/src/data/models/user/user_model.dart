class UserModel {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;
  final String? fcmToken;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.fcmToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      emergencyPhoneNumber: json['emergency_phone_number'] as String? ?? '',
      email: json['email'],
      fcmToken: json['fcm_token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'name': name,
      'phone_number': phoneNumber,
      'emergency_phone_number': emergencyPhoneNumber,
      'email': email,
    };
  }

  UserModel copyWith({
    String? id,
    String? authId,
    String? communityId,
    DateTime? createdAt,
    String? createdBy,
    String? name,
    String? phoneNumber,
    String? emergencyPhoneNumber,
    String? email,
    String? fcmToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emergencyPhoneNumber: emergencyPhoneNumber ?? this.emergencyPhoneNumber,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}
