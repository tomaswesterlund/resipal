class PropertyRef {
  final String id;
  final String name;

  PropertyRef({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }
}
