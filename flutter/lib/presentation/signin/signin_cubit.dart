import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/service_locator.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/domain/use_cases/get_user.dart';
import 'package:resipal/domain/use_cases/user_onboarded.dart';
import 'package:resipal/presentation/signin/signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthService _sessionService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  SigninCubit() : super(InitialState());

  Future signin() async {
    try {
      await _sessionService.signInWithGoogle();
      final authUser = _sessionService.getSignedInUser();
      final userId = authUser.id;
      
      await ServiceLocator.initializeUserScope(userId);

      final userOnboarded = UserOnboarded().call(userId);

      if (userOnboarded) {
        final user = GetUser().call(userId);
        emit(UserSignedInSuccessfullyState(userOnboarded: true, user: user));
      } else {
        emit(UserSignedInSuccessfullyState(userOnboarded: false));
      }
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        stackTrace: stack,
        featureArea: 'SigninCubit.signin',
      );
      emit(ErrorState());
    }
  }
}
