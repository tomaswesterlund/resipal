class ApplicationModel {
  final String id;
  final String? userId;
  final String communityId;
  final DateTime createdAt;
  final String createdBy;
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;
  final String status;
  final String message;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  ApplicationModel({
    required this.id,
    required this.userId,
    required this.communityId,
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

  factory ApplicationModel.fromMap(Map<String, dynamic> json) {
    return ApplicationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      communityId: json['community_id'] as String,
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      emergencyPhoneNumber: json['emergency_phone_number'] as String?,
      email: json['email'] as String,
      status: json['status'] as String? ?? 'pending_approval',
      message: json['message'] as String? ?? '',
      isAdmin: json['is_admin'] as bool? ?? false,
      isResident: json['is_resident'] as bool? ?? false,
      isSecurity: json['is_security'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'community_id': communityId,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
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

  ApplicationModel copyWith({
    String? id,
    String? userId,
    String? communityId,
    DateTime? createdAt,
    String? createdBy,
    String? name,
    String? phoneNumber,
    String? emergencyPhoneNumber,
    String? email,
    String? status,
    String? message,
    bool? isAdmin,
    bool? isResident,
    bool? isSecurity,
  }) {
    return ApplicationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      communityId: communityId ?? this.communityId,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emergencyPhoneNumber: emergencyPhoneNumber ?? this.emergencyPhoneNumber,
      email: email ?? this.email,
      status: status ?? this.status,
      message: message ?? this.message,
      isAdmin: isAdmin ?? this.isAdmin,
      isResident: isResident ?? this.isResident,
      isSecurity: isSecurity ?? this.isSecurity,
    );
  }
}
