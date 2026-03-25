import 'package:ui/inputs/validation/input_field_validator.dart';

class ValueNotEmpty extends InputFieldValidator<String> {
  const ValueNotEmpty();
  @override
  String? validate(String value) => value.isEmpty ? 'Este campo es obligatorio' : null;
}
