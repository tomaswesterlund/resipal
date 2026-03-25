import 'package:equatable/equatable.dart';
import 'package:ui/inputs/validation/input_field.dart';

class RegisterApplicationFormState extends Equatable {
  final InputField<String> name;
  final InputField<String> email;
  final InputField<String> phoneNumber;
  final InputField<String> emergencyPhoneNumber;
  final InputField<String> message;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;
  final String? rolesError;

  const RegisterApplicationFormState({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.message,
    this.isAdmin = false,
    this.isResident = true,
    this.isSecurity = false,
    this.rolesError,
  });

  RegisterApplicationFormState copyWith({
    InputField<String>? name,
    InputField<String>? email,
    InputField<String>? phoneNumber,
    InputField<String>? emergencyPhoneNumber,
    InputField<String>? message,
    bool? isAdmin,
    bool? isResident,
    bool? isSecurity,
    String? rolesError,
    bool clearRolesError = false,
  }) {
    return RegisterApplicationFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emergencyPhoneNumber: emergencyPhoneNumber ?? this.emergencyPhoneNumber,
      message: message ?? this.message,
      isAdmin: isAdmin ?? this.isAdmin,
      isResident: isResident ?? this.isResident,
      isSecurity: isSecurity ?? this.isSecurity,
      rolesError: clearRolesError ? null : (rolesError ?? this.rolesError),
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    phoneNumber,
    emergencyPhoneNumber,
    message,
    isAdmin,
    isResident,
    isSecurity,
    rolesError,
  ];

  RegisterApplicationFormState validate() {
    return copyWith(
      name: name.validate(),
      email: email.validate(),
      phoneNumber: phoneNumber.validate(),
      emergencyPhoneNumber: emergencyPhoneNumber.validate(),
      message: message.validate(),
      rolesError: areRolesValid ? null : 'Debes seleccionar al menos un rol',
    );
  }

  bool get areRolesValid => isAdmin || isResident || isSecurity;

  bool get isValid =>
      name.isValid &&
      email.isValid &&
      phoneNumber.isValid &&
      emergencyPhoneNumber.isValid &&
      message.isValid &&
      areRolesValid;
}
