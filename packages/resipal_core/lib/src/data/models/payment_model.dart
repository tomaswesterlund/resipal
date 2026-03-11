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
    this.reference,
    this.note,
    this.receiptPath,
  });

  PaymentModel copyWith({
    String? id,
    String? communityId,
    String? userId,
    DateTime? createdAt,
    String? createdBy,
    int? amountInCents,
    String? status,
    DateTime? date,
    String? reference,
    String? note,
    String? receiptPath,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      communityId: communityId ?? this.communityId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      amountInCents: amountInCents ?? this.amountInCents,
      status: status ?? this.status,
      date: date ?? this.date,
      reference: reference ?? this.reference,
      note: note ?? this.note,
      receiptPath: receiptPath ?? this.receiptPath,
    );
  }

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
