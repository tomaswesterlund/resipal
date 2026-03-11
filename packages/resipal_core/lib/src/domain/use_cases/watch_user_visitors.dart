import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/visitor_data_source.dart';
import 'package:resipal_core/src/domain/entities/visitor_entity.dart';
import 'package:resipal_core/src/domain/use_cases/get_visitor.dart';
import 'package:resipal_core/src/services/logger_service.dart';

class WatchUserVisitors {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();
  final GetVisitor _getVisitor = GetVisitor();

  Stream<List<VisitorEntity>> call(String userId) {
    return _source
        .watchByUserId(userId)
        .map((models) {
          final entities = models.map((model) => _getVisitor.fromModel(model)).toList();
          return entities;
        })
        .handleError((e, s) {
          _logger.error(
            exception: e,
            featureArea: 'WatchUserVisitors',
            stackTrace: s,
            metadata: {'userId': userId},
          );
        });
  }
}
