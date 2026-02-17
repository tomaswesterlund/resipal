import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_admin/presentation/auth/auth_state.dart';
import 'package:resipal_core/domain/use_cases/get_user.dart';
import 'package:resipal_core/services/admin_scope_service.dart';
import 'package:resipal_core/services/auth_service.dart';
import 'package:resipal_core/services/logger_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();
  final AdminScopeService _adminScopeService = GetIt.I<AdminScopeService>();

  AuthCubit() : super(InitialState());

  Future initialize() async {
    try {
      emit(LoadingState());
      await Future.delayed(Duration.zero);

      if (_authService.userIsSignedIn) {
        final userId = _authService.getSignedInUserId();
        await _adminScopeService.initializeUserScope(userId);
        final user = GetUser().call(userId);

        // TODO: CHECK IF ADMIN!
        
        emit(UserSignedIn(user));
      } else {
        emit(UserNotSignedIn());
      }
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'AuthCubit.initialize', stackTrace: s);
      emit(ErrorState());
    }
  }
}
