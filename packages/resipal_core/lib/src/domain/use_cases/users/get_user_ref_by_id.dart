import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/user_data_source.dart';
import 'package:resipal_core/src/domain/refs/user_ref.dart';
import 'package:resipal_core/src/services/logger_service.dart';

class GetUserRefById {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final UserDataSource _source = GetIt.I<UserDataSource>();

  UserRef call({required String userId}) {
    try {
      final model = _source.getById(userId);

      if (model == null) {
        throw Exception('UserId $userId not found in cache. Ensure the stream is active.');
      }

      return UserRef(id: model.id, name: model.name, email: model.email, phoneNumber: model.phoneNumber);
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'GetUserRef', stackTrace: s);
      rethrow;
    }
  }
}
