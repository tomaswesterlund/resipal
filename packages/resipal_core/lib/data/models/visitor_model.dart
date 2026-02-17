class VisitorModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final String name;
  final String identificationPath;

  VisitorModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.name,
    required this.identificationPath,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    return VisitorModel(
      id: json['id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      name: json['name'],
      identificationPath: json['identification_path'],
    );
  }
}
