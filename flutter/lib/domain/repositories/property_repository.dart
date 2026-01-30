import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/property_model.dart';
import 'package:resipal/data/sources/property_data_source.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/refs/property_ref.dart';
import 'package:resipal/domain/repositories/maintenance_repository.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:rxdart/streams.dart';

class PropertyRepository {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();

  final Map<String, PropertyEntity> _cache = {};
  late Stream<List<PropertyEntity>> _stream;

  PropertyRepository() {
    _stream = _propertyDataSource
        .watchProperties()
        .asyncMap((models) => _processAndCache(models))
        .shareValue();

    _stream.listen((_) {}, onError: (e) => print('Property Stream Error: $e'));
  }

  Stream<List<PropertyEntity>> watchPropertiesByUserId(String userId) => _stream
      .map((list) => list.where((p) => p.user.id == userId).toList())
      .distinct();

  List<PropertyEntity> getPropertiesByUserId(String userId) =>
      _cache.values.where((p) => p.user.id == userId).toList();

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

  Future<PropertyEntity> _toEntity(PropertyModel model) async {
    final maintenanceRepository = GetIt.I<MaintenanceRepository>();
    final userRepository = GetIt.I<UserRepository>();

    return PropertyEntity(
      id: model.id,
      user: await userRepository.getUserRefById(model.userId),
      contract: await maintenanceRepository.getMaintenanceContractByPropertyId(
        model.id,
      ),
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

        final entity = await _toEntity(model);
        _cache[model.id] = entity;
        return entity;
      }),
    );
  }
}
