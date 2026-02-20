import 'package:resipal_core/domain/entities/id_entity.dart';

class UserRef extends IdEntity {
  final String name;

  UserRef({required super.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }
}
