class EmailInvitationModel {
  final String id;
  final String communityId;
  final DateTime createdAt;
  final String createdBy;
  final String email;
  final String name;
  final String message;

  EmailInvitationModel({
    required this.id,
    required this.communityId,
    required this.createdAt,
    required this.createdBy,
    required this.email,
    required this.name,
    required this.message,
  });

  factory EmailInvitationModel.fromMap(Map<String, dynamic> json) {
    return EmailInvitationModel(
      id: json['id'] as String,
      communityId: json['community_id'] as String,
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'community_id': communityId,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'email': email,
      'name': name,
      'message': message,
    };
  }

  Map<String, dynamic> toUpsertMap() {
    return {
      'community_id': communityId,
      'email': email,
      'name': name,
      'message': message,
    };
  }

  EmailInvitationModel copyWith({
    String? id,
    String? communityId,
    DateTime? createdAt,
    String? createdBy,
    String? email,
    String? name,
    String? message,
  }) {
    return EmailInvitationModel(
      id: id ?? this.id,
      communityId: communityId ?? this.communityId,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      email: email ?? this.email,
      name: name ?? this.name,
      message: message ?? this.message,
    );
  }
}
