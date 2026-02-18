class PropertyModel {
  final String id;
  final String communityId;
  final String? ownerId;
  final String? contractId;
  final DateTime createdAt;
  final String createdBy;
  final String name;
  final String? description;

  PropertyModel({
    required this.id,
    required this.communityId,
    required this.ownerId,
    required this.contractId,
    required this.createdAt,
    required this.createdBy,
    required this.name,
    required this.description,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      communityId: json['community_id'],
      ownerId: json['owner_id'],
      contractId: json['contract_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      name: json['name'],
      description: json['description'],
    );
  }
}