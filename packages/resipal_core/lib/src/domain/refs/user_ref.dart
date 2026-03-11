import 'package:resipal_core/src/domain/entities/id_entity.dart';

class UserRef extends IdEntity {
  final String name;
  final String email;
  final String phoneNumber;

  UserRef({required super.id, required this.name, required this.email, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'email': email, 'phoneNumber': phoneNumber};
  }
}
