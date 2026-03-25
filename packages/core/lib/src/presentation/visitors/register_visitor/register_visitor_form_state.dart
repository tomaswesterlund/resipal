import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/inputs/validation/input_field.dart';

class RegisterVisitorFormState extends Equatable {
  final InputField<String> name;
  final InputField<XFile?> image;
  // final XFile? idImage;

  const RegisterVisitorFormState({required this.name, required this.image});

  RegisterVisitorFormState copyWith({InputField<String>? name, InputField<XFile?>? image}) {
    return RegisterVisitorFormState(name: name ?? this.name, image: image ?? this.image);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'image': image.value?.path};
  }

  @override
  List<Object?> get props => [name, image];
  RegisterVisitorFormState validate() {
    return copyWith(name: name.validate(), image: image.validate());
  }

  bool get isValid => name.isValid && image.isValid;
}
