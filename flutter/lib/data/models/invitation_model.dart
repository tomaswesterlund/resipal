class InvitationModel {
  final String id;
  final String userId;
  final String propertyId;
  final String visitorId;
  final DateTime createdAt;
  final String qrCodeToken;
  final DateTime fromDate;
  final DateTime toDate;
  final int maxEntries;

  InvitationModel({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.visitorId,
    required this.createdAt,
    required this.qrCodeToken,
    required this.fromDate,
    required this.toDate,
    required this.maxEntries,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'],
      userId: json['user_id'],
      propertyId: json['property_id'],
      visitorId: json['visitor_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      qrCodeToken: json['qr_code_token'],
      fromDate: DateTime.parse(json['from_date'].toString()),
      toDate: DateTime.parse(json['to_date'].toString()),
      maxEntries: int.parse(json['max_entries'].toString()),
    );
  }
}
