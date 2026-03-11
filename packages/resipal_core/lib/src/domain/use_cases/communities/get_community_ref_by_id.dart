import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/community_data_source.dart';
import 'package:resipal_core/src/domain/refs/community_ref.dart';
import 'package:resipal_core/src/services/logger_service.dart';

class GetCommunityRefById {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  CommunityRef call({required String communityId}) {
    try {
      final model = _source.getById(communityId);

      if (model == null) {
        throw Exception('Community $communityId not found in cache. Ensure the stream is active.');
      }

      return CommunityRef(id: model.id, name: model.name);
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'GetCommunityRef', stackTrace: s);
      rethrow;
    }
  }
}
