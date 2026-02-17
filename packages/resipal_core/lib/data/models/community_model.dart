class CommunityModel {
  final String id;
  final String name;
  final String key;
  final String location;
  final String? description;

  CommunityModel({
    required this.id,
    required this.name,
    required this.key,
    required this.location,
    required this.description,
  });

  factory CommunityModel.fromMap(Map<String, dynamic> map) {
    return CommunityModel(
      id: map['id'],
      name: map['name'],
      key: map['key'],
      location: map['location'],
      description: map['description'],
    );
  }
}
