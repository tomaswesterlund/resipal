class UpsertCommunityModel {
  final String name;
  final String location;
  final String? description;

  UpsertCommunityModel({required this.name, required this.location, required this.description});

  Map<String, dynamic> toMap() {
    return {'name': name, 'location': location, 'description': description};
  }
}
