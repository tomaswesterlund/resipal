class VisitorModel {
  final String id;
  final String communityId;
  final String userId;
  final DateTime createdAt;
  final String createdBy;

  final String name;
  final String identificationPath;

  VisitorModel({
    required this.id,
    required this.communityId,
    required this.userId,
    required this.createdAt,
    required this.createdBy,
    required this.name,
    required this.identificationPath,
  });

  factory VisitorModel.fromMap(Map<String, dynamic> json) {
    return VisitorModel(
      id: json['id'],
      communityId: json['community_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      name: json['name'],
      identificationPath: json['identification_path'],
    );
  }
}
