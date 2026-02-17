import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';
import 'package:resipal_core/domain/use_cases/get_user.dart';
import 'package:resipal_core/services/auth_service.dart';
import 'package:resipal_core/services/logger_service.dart';

class GetSignedInUser {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  UserEntity call() {
    try {
      final userId = _authService.getSignedInUserId();
      final user = GetUser().call(userId);
      return user;
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'GetSignedInUser', stackTrace: s);
      rethrow;
    }
  }
}
