import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_resident/presentation/signin/signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  SigninCubit() : super(SigninInitialState());

  Future signin() async {
    try {
      emit(SigninUserSigningInState());

      await _authService.signInWithGoogle();

      final authUser = _authService.getSignedInUser();
      final userId = authUser.id;

      //await _sessionService.start(userId);

      emit(SigninUserSignedInSuccessfullyState());
    } catch (e, stack) {
      _logger.error(exception: e, stackTrace: stack, featureArea: 'SigninCubit.signin');
      emit(SigninErrorState());
    }
  }
}
