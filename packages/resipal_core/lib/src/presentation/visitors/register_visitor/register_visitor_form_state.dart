import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class RegisterVisitorFormState extends Equatable {
  final String name;
  final XFile? idImage;

  const RegisterVisitorFormState({this.name = '', this.idImage});

  // El nombre es requerido y la imagen de identificación también para proceder
  bool get canSubmit => name.trim().isNotEmpty && idImage != null;

  RegisterVisitorFormState copyWith({String? name, XFile? idImage}) {
    return RegisterVisitorFormState(name: name ?? this.name, idImage: idImage ?? this.idImage);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'idImage': idImage?.path};
  }

  @override
  List<Object?> get props => [name, idImage];
}
