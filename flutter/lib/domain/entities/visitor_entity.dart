import 'package:resipal/domain/refs/user_ref.dart';

class VisitorEntity {
  final String id;
  final UserRef user;
  final DateTime createdAt;
  final String name;

  VisitorEntity({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.name,
  });

}
