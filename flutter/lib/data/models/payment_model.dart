class PaymentModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final int amountInCents;
  final String status;
  final DateTime date;
  final String? reference;
  final String? note;

  PaymentModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.amountInCents,
    required this.status,
    required this.date,
    required this.reference,
    required this.note,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      amountInCents: int.parse(json['amount_in_cents'].toString()),
      status: json['status'],
      date: DateTime.parse(json['date'].toString()),
      reference: json['reference'],
      note: json['note'],
    );
  }
}
