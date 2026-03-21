import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

class RegisterApplicationFormState extends Equatable {
  final InputField<String> name;
  final InputField<String> email;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String message;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  const RegisterApplicationFormState({
    required this.name,
    required this.email,
    this.phoneNumber = '',
    this.emergencyPhoneNumber,
    this.message = '',
    this.isAdmin = false,
    this.isResident = true,
    this.isSecurity = false,
  });

  RegisterApplicationFormState copyWith({
    InputField<String>? name,
    InputField<String>? email,
    String? phoneNumber,
    String? emergencyPhoneNumber,
    String? message,
    bool? isAdmin,
    bool? isResident,
    bool? isSecurity,
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
    );
  }

  @override
  List<Object?> get props => [name, email, phoneNumber, emergencyPhoneNumber, message, isAdmin, isResident, isSecurity];

  RegisterApplicationFormState validate() {
    return copyWith(name: name.validate(), email: email.validate());
  }

  bool get isValid => name.isValid && email.isValid;
}