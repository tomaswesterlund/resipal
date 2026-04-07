import 'package:equatable/equatable.dart';
import 'package:ui/inputs/validation/input_field.dart';
import 'package:ui/inputs/validation/email_is_valid.dart';
import 'package:ui/inputs/validation/value_not_empty.dart';

class EmailSignInFormState extends Equatable {
  final InputField<String> email;
  final InputField<String> password;

  const EmailSignInFormState({required this.email, required this.password});

  factory EmailSignInFormState.initial() => EmailSignInFormState(
    email: InputField<String>(
      value: '',
      validators: [const ValueNotEmpty(), EmailIsValid(errorText: 'Ingresa un correo válido')],
    ),
    password: InputField<String>(
      value: '',
      validators: [const ValueNotEmpty()],
    ),
  );

  EmailSignInFormState copyWith({InputField<String>? email, InputField<String>? password}) {
    return EmailSignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  EmailSignInFormState validate() {
    return copyWith(email: email.validate(), password: password.validate());
  }

  bool get isValid => email.isValid && password.isValid;

  @override
  List<Object?> get props => [email, password];
}
