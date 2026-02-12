import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/service_locator.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/domain/use_cases/get_community_ref.dart';
import 'package:resipal/domain/use_cases/get_user.dart';
import 'package:resipal/domain/use_cases/user_onboarding_completed.dart';
import 'package:resipal/presentation/signin/signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  SigninCubit() : super(InitialState());

  Future initialize() async {
    try {
      if (_authService.userIsSignedIn) {
        final userId = _authService.getSignedInUserId();
        await ServiceLocator.initializeSigninScope(userId);
        final user = GetUser().call(userId);
        emit(UserAlreadySignedInState(user));
      } else {
        emit(UserNotSignedInState());
      }
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'SigninCubit.initialize', stackTrace: s);
      emit(ErrorState());
    }
  }

  Future signin() async {
    try {
      emit(UserSigningInState());
      await _authService.signInWithGoogle();
      final authUser = _authService.getSignedInUser();
      final userId = authUser.id;

      await ServiceLocator.initializeSigninScope(userId);
      final userOnboarded = await UserOnboardingCompleted().call(userId);

      if (userOnboarded) {
        final user = GetUser().call(userId);
        emit(UserSignedInSuccessfullyAndOnboardedState(user));
      } else {
        emit(UserSignedInSuccessfullyButNotOnboardedState(userId: userId));
      }
    } catch (e, stack) {
      _logger.logException(exception: e, stackTrace: stack, featureArea: 'SigninCubit.signin');
      emit(ErrorState());
    }
  }
}
