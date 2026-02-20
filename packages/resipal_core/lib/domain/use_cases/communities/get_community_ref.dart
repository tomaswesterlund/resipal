import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/models/community_model.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/domain/refs/community_ref.dart';
import 'package:resipal_core/services/logger_service.dart';

class GetCommunityRef {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  CommunityRef fromId(String id) {
    try {
      final model = _source.getById(id);

      if (model == null) {
        throw Exception(
          'Community $id not found in cache. Ensure the stream is active.',
        );
      }

      return fromModel(model);
    } catch (e, s) {
      _logger.logException(
        exception: e,
        featureArea: 'GetCommunityRef',
        stackTrace: s,
      );
      rethrow;
    }
  }

  CommunityRef fromModel(CommunityModel model) =>
      CommunityRef(id: model.id, name: model.name);
}
