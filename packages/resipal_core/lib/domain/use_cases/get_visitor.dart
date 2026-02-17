import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/models/visitor_model.dart';
import 'package:resipal_core/data/sources/visitor_data_source.dart';
import 'package:resipal_core/domain/entities/visitor_entity.dart';

class GetVisitor {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  VisitorEntity fromId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Visitor $id not found in cache. Ensure the stream is active.');
    }

    return fromModel(model);
  }

  VisitorEntity fromModel(VisitorModel model) {
    return VisitorEntity(
      id: model.id,
      userId: model.userId,
      createdAt: model.createdAt,
      name: model.name,
      identificationPath: model.identificationPath,
    );
  }
}
