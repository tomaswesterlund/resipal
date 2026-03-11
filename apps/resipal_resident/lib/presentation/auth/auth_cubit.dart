import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_resident/presentation/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  AuthCubit() : super(AuthInitialState());

  Future initialize() async {
    try {
      emit(AuthLoadingState());
      await Future.delayed(Duration.zero);

      if (_authService.userIsSignedIn) {
        final userId = _authService.getSignedInUserId();
        // await _sessionService.initializeUserScope(userId);
        // final user = GetUser().call(userId);
        // emit(AuthUserSignedIn(user));
      } else {
        emit(AuthUserNotSignedIn());
      }
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'AuthCubit.initialize',
        stackTrace: s,
      );
      emit(AuthErrorState());
    }
  }
}
