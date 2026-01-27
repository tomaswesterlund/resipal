class MaintenanceFeeModel {
  final String id;
  final String contractId;
  final DateTime createdAt;
  final int amountInCents;
  final String status;
  final DateTime fromDate;
  final DateTime toDate;
  final String? note;

  MaintenanceFeeModel({
    required this.id,
    required this.contractId,
    required this.createdAt,
    required this.amountInCents,
    required this.status,
    required this.fromDate,
    required this.toDate,
    required this.note,
  });

  factory MaintenanceFeeModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceFeeModel(
      id: json['id'],
      contractId: json['contract_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      amountInCents: int.parse(json['amount_in_cents'].toString()),
      status: json['status'],
      fromDate: DateTime.parse(json['from_date'].toString()),
      toDate: DateTime.parse(json['to_date'].toString()),
      note: json['note'],
    );
  }
}
