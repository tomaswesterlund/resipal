class PropertyModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final String name;
  final String? description;

  PropertyModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.name,
    required this.description,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      name: json['name'],
      description: json['description'],
    );
  }
}
