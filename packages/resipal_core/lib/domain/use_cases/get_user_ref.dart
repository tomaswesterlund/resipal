import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/models/user_model.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/domain/refs/user_ref.dart';
import 'package:resipal_core/services/logger_service.dart';

class GetUserRef {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final UserDataSource _source = GetIt.I<UserDataSource>();

  UserRef fromId(String id) {
    try {
      final model = _source.getById(id);

      if (model == null) {
        throw Exception('Community $id not found in cache. Ensure the stream is active.');
      }

      return fromModel(model);
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'GetUserRef', stackTrace: s);
      rethrow;
    }
  }

  UserRef fromModel(UserModel model) => UserRef(id: model.id, name: model.name);
}
