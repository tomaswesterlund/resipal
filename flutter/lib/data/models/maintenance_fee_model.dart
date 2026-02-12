class MaintenanceFeeModel {
  final String id;
  final String contractId;
  final String propertyId;
  final DateTime createdAt;
  final int amountInCents;
  final DateTime dueDate;
  final DateTime? paymentDate;
  final DateTime fromDate;
  final DateTime toDate;
  final String? note;

  MaintenanceFeeModel({
    required this.id,
    required this.contractId,
    required this.propertyId,
    required this.createdAt,
    required this.amountInCents,
    required this.dueDate,
    required this.paymentDate,
    required this.fromDate,
    required this.toDate,
    required this.note,
  });

  factory MaintenanceFeeModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceFeeModel(
      id: json['id'],
      contractId: json['contract_id'],
      propertyId: json['property_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      amountInCents: int.parse(json['amount_in_cents'].toString()),
      dueDate: DateTime.parse(json['due_date'].toString()),
      paymentDate: json['payment_date'] == null ? null : DateTime.parse(json['payment_date'].toString()),
      fromDate: DateTime.parse(json['from_date'].toString()),
      toDate: DateTime.parse(json['to_date'].toString()),
      note: json['note'],
    );
  }
}
