class InvitationModel {
  final String id;
  final String communityId;
  final String userId;
  final String propertyId;
  final String visitorId;
  final DateTime createdAt;
  final String createdBy;
  final String qrCodeToken;
  final DateTime fromDate;
  final DateTime toDate;
  final int? maxEntries;

  InvitationModel({
    required this.id,
    required this.communityId,
    required this.userId,
    required this.propertyId,
    required this.visitorId,
    required this.createdAt,
    required this.createdBy,
    required this.qrCodeToken,
    required this.fromDate,
    required this.toDate,
    required this.maxEntries,
  });

  factory InvitationModel.fromMap(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'],
      communityId: json['community_id'],
      userId: json['user_id'],
      propertyId: json['property_id'],
      visitorId: json['visitor_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      qrCodeToken: json['qr_code_token'],
      fromDate: DateTime.parse(json['from_date'].toString()),
      toDate: DateTime.parse(json['to_date'].toString()),
      maxEntries: json['max_entries'] != null ? int.parse(json['max_entries'].toString()) : null,
    );
  }
}
