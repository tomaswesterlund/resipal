import 'package:ui/inputs/validation/input_field_validator.dart';

class ValueNotAboveCharacterCount extends InputFieldValidator<String> {
  final int max;
  const ValueNotAboveCharacterCount(this.max);
  @override
  String? validate(String value) => value.length > max ? 'Máximo $max caracteres' : null;
}
