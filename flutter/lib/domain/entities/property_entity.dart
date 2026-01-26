import 'package:resipal/domain/refs/user_ref.dart';

class PropertyEntity {
  final String id;
  final UserRef user;
  final DateTime createdAt;
  final String name;
  final String? description;

  PropertyEntity({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.name,
    required this.description,
  });
}
