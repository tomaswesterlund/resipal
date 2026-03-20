import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

class RegisterApplicationFormState extends Equatable {
  final String name;
  final InputField<String> email;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String message;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  const RegisterApplicationFormState({
    this.name = '',
    this.email = const InputField<String>(value: ''),
    this.phoneNumber = '',
    this.emergencyPhoneNumber,
    this.message = '',
    this.isAdmin = false,
    this.isResident = true,
    this.isSecurity = false
  });



  RegisterApplicationFormState copyWith({
    String? name,
    InputField<String>? email,
    String? phoneNumber,
    String? emergencyPhoneNumber,
    String? message,
    bool? isAdmin,
    bool? isResident,
    bool? isSecurity
  }) {
    return RegisterApplicationFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emergencyPhoneNumber: emergencyPhoneNumber ?? this.emergencyPhoneNumber,
      message: message ?? this.message,
      isAdmin: isAdmin ?? this.isAdmin,
      isResident: isResident ?? this.isResident,
      isSecurity: isSecurity ?? this.isSecurity
    );
  }

  @override
  List<Object?> get props => [name, email, phoneNumber, emergencyPhoneNumber, message, isAdmin, isResident, isSecurity];
}


class InputField<T> extends Equatable {
  final T value;
  final String? errorMessage;

  const InputField({
    required this.value, 
    this.errorMessage,
  });

  bool get isValid => errorMessage == null;
  bool get hasError => errorMessage != null;

  InputField<T> copyWith({
    T? value,
    String? errorMessage,
    bool clearError = false,
  }) {
    return InputField<T>(
      value: value ?? this.value,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [value, errorMessage];
}