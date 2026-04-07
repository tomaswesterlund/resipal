import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:core/lib.dart';
import 'package:security/presentation/signin/signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  SigninCubit() : super(SigninInitialState());

  Future signin(SignInProvider provider) async {
    try {
      emit(SigninUserSigningInState());

      switch (provider) {
        case SignInProvider.google:
          await _authService.signInWithGoogle();
          break;
        case SignInProvider.apple:
          await _authService.signInWithApple();
          break;
      }

      final authUser = _authService.getSignedInUser();
      _sessionService.setUserId(authUser.id);

      emit(SigninUserSignedInSuccessfullyState());
    } catch (e, stack) {
      if (e is GoogleSignInException) {
        if (e.code == GoogleSignInExceptionCode.canceled) {
          emit(SigninInitialState());
          return;
        }
      }

      _logger.error(exception: e, stackTrace: stack, featureArea: 'SigninCubit.signin');
      emit(SigninErrorState());
    }
  }

  Future signInWithEmailSuccessfully() async {
    try {
      emit(SigninUserSigningInState());
      emit(SigninUserSignedInSuccessfullyState());
    } catch (e, stack) {
      _logger.error(exception: e, stackTrace: stack, featureArea: 'SigninCubit.signInWithEmailSuccessfully');
      emit(SigninErrorState());
    }
  }
}
