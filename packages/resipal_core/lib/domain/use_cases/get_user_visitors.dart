import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/visitor_data_source.dart';
import 'package:resipal_core/domain/entities/visitor_entity.dart';
import 'package:resipal_core/domain/use_cases/get_visitor.dart';

class GetUserVisitors {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();
  final GetVisitor _getVisitor = GetVisitor();

  List<VisitorEntity> call(String userId) {
    final models = _source.getByUserId(userId);
    final visitors = models.map((model) => _getVisitor.fromModel(model)).toList();
    return visitors;
  }
}
