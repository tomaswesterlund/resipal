import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/models/visitor_model.dart';
import 'package:resipal_core/src/data/sources/visitor_data_source.dart';
import 'package:resipal_core/src/domain/refs/visitor_ref.dart';

class GetVisitorRef {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  VisitorRef fromId(String id) {
    final model = _source.getById(id);
    if (model == null) {
      throw Exception('Visitor $id not found in cache. Ensure the stream is active.');
    }
    return VisitorRef(id: model.id, name: model.name);
  }

  VisitorRef fromModel(VisitorModel model) => VisitorRef(id: model.id, name: model.name);
}
