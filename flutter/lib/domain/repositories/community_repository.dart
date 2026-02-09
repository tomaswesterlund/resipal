import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/community_model.dart';
import 'package:resipal/data/sources/community_data_source.dart';
import 'package:resipal/domain/entities/community_entity.dart';
import 'package:rxdart/streams.dart';

class CommunityRepository {
  final LoggerService _logger;
  final CommunityDataSource _communityDataSource;

  final Map<String, CommunityEntity> _cache = {};
  late final Stream<List<CommunityEntity>> _stream;

  CommunityRepository(this._logger, this._communityDataSource) {
    _stream = _communityDataSource.watchCommunities().asyncMap((models) => _processAndCache(models)).shareValue();
  }

  Future initialize() async {
    final firstData = await _communityDataSource.watchCommunities().first;
    await _processAndCache(firstData);
    _stream.listen((_) {}, onError: (e) => print('Property Stream Error: $e'));
    _logger.info('✅ CommunityRepository initialized');
  }

  List<CommunityEntity> getCommunities() => _cache.values.toList();

  Future joinCommunity({required String userId, required String communityId}) =>
      _communityDataSource.joinCommunity(userId: userId, communityId: communityId);

  Future<CommunityEntity> _toEntity(CommunityModel model) async {
    return CommunityEntity(
      id: model.id,
      name: model.name,
      key: model.key,
      location: model.location,
      description: model.description,
    );
  }

  Future<List<CommunityEntity>> _processAndCache(List<CommunityModel> models) async {
    return Future.wait(
      models.map((model) async {
        if (_cache.containsKey(model.id)) {
          final current = _cache[model.id];
          final updated = await _toEntity(model);

          if (current != updated) {
            _cache[model.id] = updated;
          }

          return _cache[model.id]!;
        } else {
          final entity = await _toEntity(model);
          _cache[model.id] = entity;
          return entity;
        }
      }),
    );
  }
}
