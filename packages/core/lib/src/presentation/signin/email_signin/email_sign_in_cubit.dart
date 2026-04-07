import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/presentation/signin/email_signin/email_sign_in_formstate.dart';
import 'package:core/src/presentation/signin/email_signin/email_sign_in_state.dart';

class EmailSignInCubit extends Cubit<EmailSignInState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  EmailSignInFormState _formState = EmailSignInFormState.initial();

  EmailSignInCubit() : super(EmailSignInInitialState());

  void initialize() {
    emit(EmailSignInFormEditingState(_formState));
  }

  void updateEmail(String value) {
    final email = _formState.email.copyWith(value: value);
    _formState = _formState.copyWith(email: email);
    emit(EmailSignInFormEditingState(_formState));
  }

  void updatePassword(String value) {
    final password = _formState.password.copyWith(value: value);
    _formState = _formState.copyWith(password: password);
    emit(EmailSignInFormEditingState(_formState));
  }

  Future<void> submit() async {
    final state = _formState.validate();
    if (!state.isValid) {
      emit(EmailSignInFormEditingState(state));
      return;
    }

    emit(EmailSignInSubmittingState());
    try {
      await _authService.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(EmailSignInSuccessState());
    } catch (e, s) {
      if (e.toString().contains('Invalid login credentials') ||
          e.toString().contains('invalid_credentials')) {
        emit(EmailSignInInvalidCredentialsState());
        return;
      }
      _logger.error(exception: e, stackTrace: s, featureArea: 'EmailSignInCubit.submit');
      emit(EmailSignInErrorState());
    }
  }
}
