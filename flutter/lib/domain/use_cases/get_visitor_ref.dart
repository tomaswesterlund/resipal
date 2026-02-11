import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';
import 'package:resipal/domain/refs/visitor_ref.dart';

class GetVisitorRef {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  VisitorRef call(String id) {
    final model = _source.getById(id);
    return VisitorRef(id: model.id, name: model.name);
  }
}