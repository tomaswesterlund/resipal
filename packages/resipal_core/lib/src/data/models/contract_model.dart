class ContractModel {
  final String id;
  final String communityId;
  final DateTime createdAt;
  final String createdBy;
  final String name;
  final String period;
  final int amountInCents;
  final String? description;

  ContractModel({
    required this.id,
    required this.communityId,
    required this.createdAt,
    required this.createdBy,
    required this.name,

    required this.period,
    required this.amountInCents,
    required this.description,
  });

  factory ContractModel.fromMap(Map<String, dynamic> json) {
    return ContractModel(
      id: json['id'],
      communityId: json['community_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      name: json['name'],
      period: json['period'],
      amountInCents: int.parse(json['amount_in_cents'].toString()),
      description: json['description'],
    );
  }
}
