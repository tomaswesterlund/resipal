class MaintenanceContractModel {
  final String id;
  final DateTime createdAt;
  final String name;
  final String period;
  final int amountInCents;
  final String? description;

  MaintenanceContractModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.period,
    required this.amountInCents,
    required this.description,
  });

  factory MaintenanceContractModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceContractModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      period: json['period'],
      amountInCents: int.parse(json['amount_in_cents'].toString()),
      description: json['description'],
    );
  }
}
