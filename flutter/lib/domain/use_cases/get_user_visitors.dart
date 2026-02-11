import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';
import 'package:resipal/domain/entities/visitor_entity.dart';
import 'package:resipal/domain/use_cases/get_property_ref.dart';

class GetUserVisitors {
  final VisitorDataSource _source = GetIt.I<VisitorDataSource>();

  List<VisitorEntity> call(String userId) {
    final models = _source.getByUserId(userId);

    final visitors = models.map((model) {
      return VisitorEntity(
        id: model.id,
        userId: model.userId,
        createdAt: model.createdAt,
        name: model.name,
        // property: GetPropertyRef().call(model.propertyId),
        identificationPath: model.identificationPath,
      );
    }).toList();

    return visitors;
  }
}
