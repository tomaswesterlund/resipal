import 'package:ui/inputs/validation/input_field_validator.dart';

class PhoneNumberIsValid extends InputFieldValidator<String> {
  final String errorText;

  const PhoneNumberIsValid({this.errorText = 'El número no es válido.'});

  @override
  String? validate(String value) {
    if (value.isEmpty) return null;

    final RegExp phoneRegExp = RegExp(r"^\+?[0-9]{7,15}$");

    return phoneRegExp.hasMatch(value) ? null : errorText;
  }
}
