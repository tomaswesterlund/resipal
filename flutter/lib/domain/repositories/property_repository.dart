import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/property_model.dart';
import 'package:resipal/data/sources/property_data_source.dart';
import 'package:resipal/domain/entities/user_property_entity.dart';
import 'package:resipal/domain/refs/property_ref.dart';
import 'package:resipal/domain/repositories/maintenance_repository.dart';
import 'package:resipal/domain/repositories/user_repository.dart';

class PropertyRepository {
  final LoggerService _logger;
  final PropertyDataSource _propertyDataSource;
  final MaintenanceRepository maintenanceRepository;

  final Map<String, PropertyEntity> _cache = {};

  PropertyRepository(this._logger, this._propertyDataSource, this.maintenanceRepository);

  Future initialize() async {
    final firstData = await _propertyDataSource.watchProperties().first;
    await _processAndCache(firstData);
    _logger.info('✅ PropertyRepository initialized');
  }

  List<PropertyEntity> getPropertiesByOwnerId(String ownerId) =>
      _cache.values.where((p) => p.owner != null && p.owner!.id == ownerId).toList();

  PropertyRef getPropertyRefById(String id) {
    try {
      final entity = _cache[id]!;
      final ref = PropertyRef(id: entity.id, name: entity.name);
      return ref;
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'PropertyRepository.getPropertyRefById',
        stackTrace: s,
        metadata: {'id': id},
      );
      rethrow;
    }
  }


  Future<PropertyEntity> _toPropertyEntity(PropertyModel model) async {
    //assert(model.ownerId != null, 'PropertyModel ownerId should not be null');
    assert(model.contractId != null, 'PropertyModel contractId should not be null');

    final userRepository = GetIt.I<UserRepository>();

    return PropertyEntity(
      id: model.id,
      communityId: model.communityId,
      owner: model.ownerId == null ? null : userRepository.getUserRefById(model.ownerId!),
      contract: await maintenanceRepository.getMaintenanceContractById(model.contractId!),
      createdAt: model.createdAt,
      name: model.name,
      description: model.description,
    );
  }

  Future<List<PropertyEntity>> _processAndCache(List<PropertyModel> models) {
    return Future.wait(
      models.map((model) async {
        // If we already processed this exact version, return from cache
        // (Note: You might need a version/updated_at check if data can change)
        if (_cache.containsKey(model.id)) {
          return _cache[model.id]!;
        }

        final entity = await _toPropertyEntity(model);
        _cache[model.id] = entity;
        return entity;
      }),
    );
  }
}
