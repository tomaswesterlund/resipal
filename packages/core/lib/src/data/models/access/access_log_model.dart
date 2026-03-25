class AccessLogModel {
  final String id;
  final String communityId;
  final String invitationId;
  final DateTime createdAt;
  final String createdBy;
  final String direction;
  final DateTime timestamp;

  AccessLogModel({
    required this.id,
    required this.communityId,
    required this.invitationId,
    required this.createdAt,
    required this.createdBy,
    required this.direction,
    required this.timestamp,
  });

  factory AccessLogModel.fromMap(Map<String, dynamic> json) {
    return AccessLogModel(
      id: json['id'],
      communityId: json['community_id'],
      invitationId: json['invitation_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      direction: json['direction'],
      timestamp: DateTime.parse(json['timestamp'].toString())
    );
  }
}
