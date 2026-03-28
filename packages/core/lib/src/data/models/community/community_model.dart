class CommunityModel {
  final String id;
  final String name;
  final String location;
  final String? description;
  final String tier;

  CommunityModel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.tier,
  });

  factory CommunityModel.fromMap(Map<String, dynamic> map) {
    return CommunityModel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      description: map['description'],
      tier: map['tier'],
    );
  }
}
