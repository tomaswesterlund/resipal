import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/property_model.dart';
import 'package:resipal/data/sources/property_data_source.dart';
import 'package:resipal/domain/entities/user_property_entity.dart';
import 'package:resipal/domain/refs/property_ref.dart';
import 'package:resipal/domain/repositories/maintenance_repository.dart';

class PropertyRepository {
  final LoggerService _logger;
  final PropertyDataSource _propertyDataSource;
  final MaintenanceRepository maintenanceRepository;

  final Map<String, UserPropertyEntity> _cache = {};

  PropertyRepository(this._logger, this._propertyDataSource, this.maintenanceRepository);

  Future initialize() async {
    final firstData = await _propertyDataSource.watchProperties().first;
    await _processAndCache(firstData);
    _logger.info('✅ PropertyRepository initialized');
  }

  List<UserPropertyEntity> getPropertiesByOwnerId(String ownerId) =>
      _cache.values.where((p) => p.ownerId == ownerId).toList();

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

  // Future<UserPropertyEntity> _toEntity(PropertyModel model) async {
  //     return UserPropertyEntity(
  //       id: model.id,
  //       communityId: ,
  //       ownerId: model.ownerId,
  //       contract: await maintenanceRepository.getMaintenanceContractByPropertyId(model.id),
  //       createdAt: model.createdAt,
  //       name: model.name,
  //       description: model.description,
  //     );
  //   }

  Future<UserPropertyEntity> _toUserPropertyEntity(PropertyModel model) async {
    assert(model.ownerId != null, 'PropertyModel ownerId should not be null');
    assert(model.contractId != null, 'PropertyModel contractId should not be null');

    return UserPropertyEntity(
      id: model.id,
      communityId: model.communityId,
      ownerId: model.ownerId!,
      contract: await maintenanceRepository.getMaintenanceContractById(model.contractId!),
      createdAt: model.createdAt,
      name: model.name,
      description: model.description,
    );
  }

  Future<List<UserPropertyEntity>> _processAndCache(List<PropertyModel> models) {
    return Future.wait(
      models.map((model) async {
        // If we already processed this exact version, return from cache
        // (Note: You might need a version/updated_at check if data can change)
        if (_cache.containsKey(model.id)) {
          return _cache[model.id]!;
        }

        final entity = await _toUserPropertyEntity(model);
        _cache[model.id] = entity;
        return entity;
      }),
    );
  }
}
