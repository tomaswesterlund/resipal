import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';

class AccessLogEntity extends Equatable {
  final String id;
  final DateTime createdAt;
  final AccessLogDirection direction;
  final DateTime timestamp;

  AccessLogEntity({
    required this.id,
    required this.createdAt,
    required this.direction,
    required this.timestamp,
  });
  
  @override
  List<Object?> get props => [id, createdAt, direction, timestamp];
}
