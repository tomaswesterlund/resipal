class PaymentModel {
  final String id;
  final String communityId;
  final String userId;
  final DateTime createdAt;
  final String createdBy;
  final int amountInCents;
  final String status;
  final DateTime date;
  final String? reference;
  final String? note;
  final String? receiptPath;

  PaymentModel({
    required this.id,
    required this.communityId,
    required this.userId,
    required this.createdAt,
    required this.createdBy,
    required this.amountInCents,
    required this.status,
    required this.date,
    required this.reference,
    required this.note,
    required this.receiptPath
  });

  factory PaymentModel.fromMap(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      communityId: json['community_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      amountInCents: int.parse(json['amount_in_cents'].toString()),
      status: json['status'],
      date: DateTime.parse(json['date'].toString()),
      reference: json['reference'],
      note: json['note'],
      receiptPath: json['receipt_path'],
    );
  }
}
