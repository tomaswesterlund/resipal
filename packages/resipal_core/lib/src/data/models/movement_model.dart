class MovementModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final int amountInCents;
  final String type;
  final String refId;

  MovementModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.amountInCents,
    required this.type,
    required this.refId,
  });

  factory MovementModel.fromJson(Map<String, dynamic> json) {
    return MovementModel(
      id: json['id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      amountInCents: int.parse(json['amount_in_cents'].toString()),
      type: json['type'],
      refId: json['ref_id'],
    );
  }
}
