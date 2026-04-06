class UpsertPaymentModel {
  final String communityId;
  final String userId;
  final int amountInCents;
  final String status;
  final DateTime date;
  final String? reference;
  final String? note;
  final String receiptPath;

  UpsertPaymentModel({
    required this.communityId,
    required this.userId,
    required this.amountInCents,
    required this.status,
    required this.date,
    required this.reference,
    required this.note,
    required this.receiptPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'community_id': communityId,
      'user_id': userId,
      'amount_in_cents': amountInCents,
      'status': status,
      'date': date.toUtc().toIso8601String(),
      'reference': reference,
      'note': note,
      'receipt_path': receiptPath,
    };
  }
}
