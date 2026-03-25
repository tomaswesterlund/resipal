class ContractRef {
  final String id;
  final String name;

  ContractRef({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }
}