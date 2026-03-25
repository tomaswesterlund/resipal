import 'package:ui/inputs/validation/input_field_validator.dart';

class EmailIsValid extends InputFieldValidator<String> {
  final String errorText;
  
  const EmailIsValid({this.errorText = 'El email no es válido.'});
  
  @override
  String? validate(String value) {
    if (value == null || value.isEmpty) return null;

    final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final hasMatch = emailRegExp.hasMatch(value);

    if (hasMatch) {
      return null;
    } else {
      return errorText;
    }
  }
}
