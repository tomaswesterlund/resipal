class AccessLogModel {
  final String id;
  final String invitationId;
  final DateTime createdAt;
  final String direction;
  final DateTime timestamp;

  AccessLogModel({
    required this.id,
    required this.invitationId,
    required this.createdAt,
    required this.direction,
    required this.timestamp,
  });

  factory AccessLogModel.fromJson(Map<String, dynamic> json) {
    return AccessLogModel(
      id: json['id'],
      invitationId: json['invitation_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      direction: json['direction'],
      timestamp: DateTime.parse(json['timestamp'].toString())
    );
  }
}
