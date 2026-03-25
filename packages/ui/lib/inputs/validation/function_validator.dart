import 'package:ui/inputs/validation/input_field_validator.dart';

class FunctionValidator<T> extends InputFieldValidator<T> {
  final String? Function(T value) validator;

  const FunctionValidator(this.validator);

  @override
  String? validate(T value) => validator(value);
}
