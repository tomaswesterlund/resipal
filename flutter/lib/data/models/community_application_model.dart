class CommunityApplicationModel {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final String communityId;
  final String userId;
  final String? message;

  CommunityApplicationModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.communityId,
    required this.userId,
    required this.message,
  });

  factory CommunityApplicationModel.fromMap(Map<String, dynamic> map) {
    return CommunityApplicationModel(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      createdBy: map['created_by'] as String,
      communityId: map['community_id'] as String,
      userId: map['user_id'] as String,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }
}
