import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';
import 'package:resipal/domain/refs/visitor_ref.dart';

class VisitorRepository {
  final VisitorDataSource _visitorDataSource = GetIt.I<VisitorDataSource>();

  Future<VisitorRef> getVisitoryRefById(String id) async {
    final model = await _visitorDataSource.getVisitorById(id);
    final ref = VisitorRef(id: model.id, name: model.name);
    return ref;
  }
}