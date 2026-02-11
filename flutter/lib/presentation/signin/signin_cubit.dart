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
      final userOnboarded = await UserOnboarded().call(userId);

      if (userOnboarded) {
        // If user has been onboarded we should initialize the user scope
        // i.e. start listening to the watcher. If not we'll leave them alone
        // and they will be started after the onboarding process has been
        // processed completely.
        await ServiceLocator.initializeUserScope(userId);
        final user = GetUser().call(userId);

        if (user.community == null) {
          emit(UserSignedInSuccessfullyState(userOnboarded: true, userJoinedCommunity: false, user: user));
        } else {
          emit(UserSignedInSuccessfullyState(userOnboarded: true, userJoinedCommunity: true, user: user));
        }
      } else {
        emit(UserSignedInSuccessfullyState(userOnboarded: false, userJoinedCommunity: false));
      }
    } catch (e, stack) {
      _logger.logException(exception: e, stackTrace: stack, featureArea: 'SigninCubit.signin');
      emit(ErrorState());
    }
  }
}
