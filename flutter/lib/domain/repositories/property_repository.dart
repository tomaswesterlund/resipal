import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/property_data_source.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/refs/property_ref.dart';
import 'package:resipal/domain/repositories/user_repository.dart';

class PropertyRepository {
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();

  Future<List<PropertyEntity>> getPropertiesByUserId(String userId) async {
    final userRepository = GetIt.I<UserRepository>();

    final models = await _propertyDataSource.getPropertiesByUserId(userId);
    final futures = models.map(
      (m) async => PropertyEntity(
        id: m.id,
        user: await userRepository.getUserRefById(m.userId),
        createdAt: m.createdAt,
        name: m.name,
        description: m.description,
      ),
    ).toList();

    final entities = Future.wait(futures);
    return entities;
  }

  Future<PropertyRef> getPropertyRefById(String id) async {
    final model = await _propertyDataSource.getPropertyById(id);
    final ref = PropertyRef(id: model.id, name: model.name);
    return ref;
  }
}
