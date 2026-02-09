import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CreateVisitorFormState extends Equatable {
  final String? name;
  final XFile? identificationImage;

  const CreateVisitorFormState({this.name, this.identificationImage});

  bool isValid() {
    return name != null && name!.isNotEmpty && identificationImage != null;
  }

  CreateVisitorFormState copyWith({String? name, XFile? identificationImage}) {
    return CreateVisitorFormState(
      name: name ?? this.name,
      identificationImage: identificationImage ?? this.identificationImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'hasIdentificationImage': identificationImage != null};
  }

  @override
  List<Object?> get props => [name, identificationImage];
}
