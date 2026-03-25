import 'package:image_picker/image_picker.dart';
import 'package:ui/inputs/validation/input_field_validator.dart';

class XFileNotNull extends InputFieldValidator<XFile?> {
  final String errorText;

  const XFileNotNull({this.errorText = 'Una imagen es obligatorio.'});
  @override
  String? validate(XFile? value) => value == null ? errorText : null;
}
