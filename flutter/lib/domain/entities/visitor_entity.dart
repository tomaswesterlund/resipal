import 'package:resipal/domain/entities/id_entity.dart';
import 'package:resipal/domain/refs/user_ref.dart';

class VisitorEntity extends IdEntity {
  final UserRef user;
  final DateTime createdAt;
  final String name;

  VisitorEntity({
    required super.id,
    required this.user,
    required this.createdAt,
    required this.name,
  });
}
