import 'package:equatable/equatable.dart';
import 'package:ui/inputs/validation/input_field_validator.dart';

class InputField<T> extends Equatable {
  final T value;
  final List<InputFieldValidator<T>> validators;
  String? errorMessage;

  InputField({required this.value, this.errorMessage = null, this.validators = const []});

  bool get isValid => errorMessage == null;
  bool get hasError => errorMessage != null;

  InputField<T> validate() {
    for (var validator in validators) {
      final error = validator.validate(value);
      if (error != null) {
        return copyWith(errorMessage: error);
      }
    }
    return copyWith(clearError: true);
  }

  InputField<T> copyWith({
    T? value,
    String? errorMessage,
    bool clearError = false,
    List<InputFieldValidator<T>>? validators,
  }) {
    return InputField<T>(
      value: value ?? this.value,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      validators: validators ?? this.validators,
    );
  }

  @override
  List<Object?> get props => [value, errorMessage, validators];
}

