class UpsertAccessLogModel {
  final String communityId;
  final String invitationId;
  final String direction;
  final DateTime timestamp;

  UpsertAccessLogModel({
    required this.communityId,
    required this.invitationId,
    required this.direction,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'community_id': communityId,
      'invitation_id': invitationId,
      'direction': direction, // 'in' or 'out'
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
