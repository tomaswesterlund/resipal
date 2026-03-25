import 'package:ui/inputs/validation/input_field_validator.dart';

class ValueNotNull<T> extends InputFieldValidator<T?> {
  final String errorMessage;

  const ValueNotNull({this.errorMessage = 'Este campo es obligatorio'});

  @override
  String? validate(T? value) {
    if (value == null) return errorMessage;

    if (value is String && value.trim().isEmpty) {
      return errorMessage;
    }

    if (value is Iterable && value.isEmpty) {
      return errorMessage;
    }

    return null;
  }
}
