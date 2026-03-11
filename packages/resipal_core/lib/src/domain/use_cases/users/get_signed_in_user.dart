import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/domain/entities/user_entity.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_user_by_id.dart';
import 'package:resipal_core/src/services/auth_service.dart';
import 'package:resipal_core/src/services/logger_service.dart';

class GetSignedInUser {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  UserEntity call() {
    try {
      final userId = _authService.getSignedInUserId();
      final user = GetUserById().call(userId);
      return user;
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'GetSignedInUser', stackTrace: s);
      rethrow;
    }
  }
}
