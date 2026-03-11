import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_user/presentation/signin/signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  SigninCubit() : super(InitialState());

  Future signin() async {
    try {
      emit(UserSigningInState());

      await _authService.signInWithGoogle(
        iosClientId: '702618865794-8901nj0vdfksfr9le1lhkgde4ertkt5v.apps.googleusercontent.com',
        serverClientId: '702618865794-djko57cpvdues3pn7ra1ab5f6to93078.apps.googleusercontent.com',
      );

      final authUser = _authService.getSignedInUser();
      final userId = authUser.id;

      await _sessionService.initializeUserScope(userId);

      emit(UserSignedInSuccessfullyState());
    } catch (e, stack) {
      _logger.error(exception: e, stackTrace: stack, featureArea: 'SigninCubit.signin');
      emit(ErrorState());
    }
  }
}
