class UpsertMembershipModel {
  final String userId;
  final String communityId;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  UpsertMembershipModel({
    required this.userId,
    required this.communityId,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'community_id': communityId,
      'is_admin': isAdmin,
      'is_resident': isResident,
      'is_security': isSecurity,
    };
  }
}
