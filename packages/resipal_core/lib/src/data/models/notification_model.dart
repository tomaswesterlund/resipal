class NotificationModel {
  final String id;
  final String communityId;
  final String userId;
  final DateTime createdAt;
  final String createdBy;
  final String app;
  final String title;
  final String message;
  final DateTime? readDate;

  NotificationModel({
    required this.id,
    required this.communityId,
    required this.userId,
    required this.createdAt,
    required this.createdBy,
    required this.app,
    required this.title,
    required this.message,
    required this.readDate,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      communityId: json['community_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      app: json['app'],
      title: json['title'],
      message: json['message'],
      readDate: json['read_date'] == null ? null : DateTime.parse(json['read_date'].toString()),
    );
  }
}
