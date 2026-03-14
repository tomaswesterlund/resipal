import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class WatchVisitorsByCommunityIdAndUserId {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();
  final GetVisitor _getVisitor = GetVisitor();

  Stream<List<VisitorEntity>> call({required String communityId, required String userId}) {
    return _source.watchByUserId(userId).map((models) {
      final entities = models.map((x) => _getVisitor.fromModel(x)).toList();
      return entities;
    });
  }
}
