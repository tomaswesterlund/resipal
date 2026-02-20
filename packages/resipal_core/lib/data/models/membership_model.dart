class MembershipModel {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final String userId;
  final String communityId;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  MembershipModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.userId,
    required this.communityId,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });

  factory MembershipModel.fromMap(Map<String, dynamic> map) {
    return MembershipModel(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at'].toString()),
      createdBy: map['created_by'] as String,
      userId: map['user_id'] as String,
      communityId: map['community_id'] as String,
      isAdmin: map['is_admin'] as bool,
      isResident: map['is_resident'] as bool,
      isSecurity: map['is_security'] as bool,
    );
  }
}
