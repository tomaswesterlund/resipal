class UpsertNotificationModel {
  final String communityId;
  final String userId;
  final String app;
  final String title;
  final String message;
  final DateTime? readDate;

  UpsertNotificationModel({
    required this.communityId,
    required this.userId,
    required this.app,
    required this.title,
    required this.message,
    required this.readDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'community_id': communityId,
      'user_id': userId,
      'app': app,
      'title': title,
      'message': message,
      'read_date': readDate?.toIso8601String(), // Returns null if readDate is null
    };
  }
}
