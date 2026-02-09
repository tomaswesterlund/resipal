import 'package:resipal/domain/entities/id_entity.dart';

class VisitorEntity extends IdEntity {
  final String userId;
  final DateTime createdAt;
  final String name;
  final String identificationPath;

  VisitorEntity({
    required super.id,
    required this.userId,
    required this.createdAt,
    required this.name,
    required this.identificationPath,
  });
}
