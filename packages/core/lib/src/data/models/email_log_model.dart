class EmailLogModel {
  final String id;
  final String invitationId;
  final String resendId;
  final DateTime createdAt;
  final String createdBy;

  EmailLogModel({
    required this.id,
    required this.invitationId,
    required this.resendId,
    required this.createdAt,
    required this.createdBy,
  });

  factory EmailLogModel.fromMap(Map<String, dynamic> json) {
    return EmailLogModel(
      id: json['id'] as String,
      invitationId: json['invitation_id'] as String,
      resendId: json['resend_id'] as String,
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invitation_id': invitationId,
      'resend_id': resendId,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
    };
  }

  EmailLogModel copyWith({
    String? id,
    String? invitationId,
    String? resendId,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return EmailLogModel(
      id: id ?? this.id,
      invitationId: invitationId ?? this.invitationId,
      resendId: resendId ?? this.resendId,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}